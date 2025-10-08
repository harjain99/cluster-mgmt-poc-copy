from typing import TypedDict, Optional

import pulumi
from pulumi_aws import s3

class MyBucketComponentArgs(TypedDict):
    bucket_name: Optional[pulumi.Input[str]]

class MyBucketComponent(pulumi.ComponentResource):
    def __init__(self, name, args: MyBucketComponentArgs, opts=None):
        super().__init__('my:module:MyBucketComponent', name, {}, opts)

        self.bucket = s3.Bucket(
            f'{name}-bucket',
            opts=pulumi.ResourceOptions(parent=self)
        )

        self.register_outputs({
            'bucket-name': self.bucket.id
        })
