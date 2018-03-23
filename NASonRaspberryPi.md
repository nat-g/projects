## How to build a Network Storage Device on a Raspberry Pi

### Prerequisites

You would need these things to build it:
* *Hub:* You'll need it if you have two HDDs. Raspberry Pi isn't powerful enough to power up both drivers. 
* *Raspberry Pi*
* *Two HDDs:* You can get by with just one. And you'll need two if you want to make them redundant. But since we're engineers why wouldn't you. :P
* *Some CLI knowledge*

### Tech desicions you need to make: 
* *Filesystem format:* I'll use NTFS here
* *Network Shares tools:* I'll be using Samba here

### Step by step guide
1. Once you have everything ready. Hook all the hardware up.

2. Then log in to your Raspberry Pi:
```
Login as: pi
pi@192.168.1.13's password:
```
