from setuptools import setup, find_packages

setup(
    name='python-components',
    version='0.1.0',
    description='Reusable Pulumi components in Python',
    packages=find_packages(),
    install_requires=[
        'pulumi>=3.0.0',
        'pulumi-aws>=5.0.0',
    ],
    python_requires='>=3.7',
    include_package_data=True,
)
