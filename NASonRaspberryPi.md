## How to build a Network Storage Device on a Raspberry Pi

### Prerequisites

You would need these things to build it:
* **Hub:** You'll need it if you have two HDDs. Raspberry Pi isn't powerful enough to power up both drivers. 
* **Raspberry Pi**
* **Two HDDs:** You can get by with just one. And you'll need two if you want to make them redundant. But since we're engineers why wouldn't you. :P
* **Some CLI knowledge**

### Tech desicions you need to make: 
1. **Filesystem format:** I'll use NTFS here
2. **Network Shares tools:** I'll be using Samba here

