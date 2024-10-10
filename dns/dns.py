import os
import sys
import json
from datetime import datetime
from cloudflare import Cloudflare


def get_env(key):
    value = os.environ.get(key)
    if value is None or value.strip() == "":
        print(f"{key} can't be empty")
        sys.exit(1)
    return value


def load_env():
    return {
        "DOMAIN": get_env("DOMAIN"),
        "CLOUDFLARE_EMAIL": get_env("CLOUDFLARE_EMAIL"),
        "CLOUDFLARE_API_KEY": get_env("CLOUDFLARE_API_KEY"),
        "ZONE_ID": get_env("ZONE_ID"),
    }


def json_serializer(obj):
    if isinstance(obj, datetime):
        return obj.isoformat()
    raise TypeError(f"Type {type(obj)} not serializable")


def get_dns_records_list():
    return cf.dns.records.list(zone_id=config["ZONE_ID"]).model_dump()


def get_dns_record_dict(records):
    return {record["name"]: record for record in records["result"]}


def get_dns_record(name, record_dict):
    return record_dict.get(name)


def create_dns_record(type, name, content, proxied):
    return cf.dns.records.create(
        zone_id=config["ZONE_ID"],
        type=type,
        name=name,
        content=content,
        proxied=proxied,
    )


def delete_dns_record(dns_record_id):
    return cf.dns.records.delete(dns_record_id=dns_record_id, zone_id=config["ZONE_ID"])


def main():
    if len(sys.argv) < 1:
        print("Usage: python3 dns.py <action>(add, rm, list) <name> <IP>")
        sys.exit(1)

    action = sys.argv[1]
    match action:
        case "add":
            try:
                name = sys.argv[2]
                ip_address = sys.argv[3]

                records = get_dns_records_list()
                records_dict = get_dns_record_dict(records)

                record = records_dict.get(f"{name}.{config['DOMAIN']}")

                if record:
                    deleted = delete_dns_record(record["id"])
                    if deleted:
                        created = create_dns_record(
                            "A", f"{name}.{config['DOMAIN']}", ip_address, True
                        )
                        if created:
                            print("DNS record updated")
                else:
                    created = create_dns_record(
                        "A", f"{name}.{config['DOMAIN']}", ip_address, True
                    )
                    if created:
                        print("New DNS record created")

            except:
                print("IP address or name can't be empty")
                sys.exit(1)

            print(ip_address, name)
        case "rm":
            try:
                name = sys.argv[2]

                records = get_dns_records_list()
                records_dict = get_dns_record_dict(records)

                record = records_dict.get(f"{name}.{config['DOMAIN']}")

                if record:
                    deleted = delete_dns_record(record["id"])
                    if deleted:
                        print("DNS record removed")
            except:
                print("name can't be empty")
                sys.exit(1)
        case "list":
            records = get_dns_records_list()
            record_dict = get_dns_record_dict(records)
            pretty = json.dumps(record_dict, indent=4, default=json_serializer)
            print(pretty)
        case _:
            print("action not valid")
            sys.exit(1)


if __name__ == "__main__":
    config = load_env()

    cf = Cloudflare(
        api_email=config.get("CLOUDFLARE_EMAIL"),
        api_key=config.get("CLOUDFLARE_API_KEY"),
    )

    main()
