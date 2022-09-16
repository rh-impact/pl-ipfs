from os import path
from setuptools import setup

with open(path.join(path.dirname(path.abspath(__file__)), 'README.rst')) as f:
    readme = f.read()

setup(
    name             = 'ipfs',
    version          = '0.1',
    description      = 'A peer-to-peer hypermedia protocol designed to preserve and grow humanity\'s knowledge by making the web upgradeable, resilient, and more open.',
    long_description = readme,
    author           = 'sgallagher',
    author_email     = 'sgallagh@redhat.com',
    url              = 'https://docs.ipfs.tech/',
    packages         = ['ipfs'],
    install_requires = ['chrisapp'],
    test_suite       = 'nose.collector',
    tests_require    = ['nose'],
    license          = 'MIT',
    zip_safe         = False,
    python_requires  = '>=3.6',
    entry_points     = {
        'console_scripts': [
            'ipfs = ipfs.__main__:main'
            ]
        }
)
