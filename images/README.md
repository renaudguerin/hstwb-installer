# Images for HstWB Installer

Example hstwb-image.json file:

```json
{
    "name": "4GB: HDF RDB, DH0 (300MB PDS\\03), DH1 (3.2GB PDS\\03)",
    "harddrives": [
        {
            "type": "hdf",
            "readOnly": "rw",
            "device": "DH0",
            "volume": "",
            "path": "4gb.hdf",
            "size": 3800000000,
            "sectors": 0,
            "surfaces": 0,
            "reserved": 0,
            "blockSize": 512,
            "bootPriority": 0,
            "partitions": [
                {
                    "device": "DH0",
                    "volume": "Workbench"
                },
                {
                    "device": "DH1",
                    "volume": "Data"
                }
            ]
        }
    ]
}
```

Formatting pfs3 partitions

pfsformat drive dh0: name "Workbench" quick noicons fnsize=107
pfsformat drive dh1: name "Data" quick noicons fnsize=107