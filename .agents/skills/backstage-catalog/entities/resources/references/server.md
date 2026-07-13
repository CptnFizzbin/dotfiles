# Server Resource Reference

Complete reference documentation for Server resource type specifications.

## Entity Declaration

| Field        | Value                   |
| ------------ | ----------------------- |
| `apiVersion` | `backstage.io/v1alpha1` |
| `kind`       | `Resource`              |
| `spec.type`  | `server`                |

## What is a Server Resource?

A Server resource describes a physical server, virtual machine, or other computer that acts as a host for databases, services, or systems.

## Basic Structure

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: bp2-bkstdev-l001
  title: Backstage Development Server
  description: Primary development server for Backstage services
spec:
  type: server
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
```

## Server-Specific Fields

Server resources support the following additional fields in `spec`:

### serverType [optional]

- Type: string
- Purpose: Type of server
- Examples: `physical`, `virtual`, `cloud-instance`, `container-host`

### osType [optional]

- Type: string
- Purpose: Operating system type
- Examples: `linux`, `windows`, `macos`

### osVersion [optional]

- Type: string
- Purpose: Operating system version
- Examples: `ubuntu-22.04`, `centos-8`, `windows-server-2019`

### dns [optional]

- Type: object
- Purpose: DNS configuration for the server

```yaml
spec:
  dns:
    fqdn: bp2-bkstdev-l001.otxlab.net
    alts:
      - backstage-dev.otxlab.net
      - backstage-uat.otxlab.net
```

### ips [optional]

- Type: array or object
- Purpose: IP addresses for the server

```yaml
spec:
  ips:
    - address: 192.168.1.100
      type: ipv4
    - address: 2001:db8::1
      type: ipv6
```

### hardware [optional]

- Type: object
- Purpose: Hardware specifications

```yaml
spec:
  hardware:
    cpu: '16-core'
    memory: '64GB'
    storage: '2TB SSD'
```

### networkInterfaces [optional]

- Type: array
- Purpose: Network interface specifications

```yaml
spec:
  networkInterfaces:
    - name: eth0
      ip: '192.168.1.100'
      gateway: '192.168.1.1'
      subnet: '255.255.255.0'
```

### location [optional]

- Type: object
- Purpose: Physical or virtual location information

```yaml
spec:
  location:
    dataCenter: us-east-1
    rack: R12
    slot: '42'
```

## Extended Example

```yaml
apiVersion: backstage.io/v1alpha1
kind: Resource
metadata:
  namespace: eng-tools
  name: bp2-bkstdev-l001
  title: Backstage Development Server
  description: |
    Primary development server for Backstage services.
    Runs PostgreSQL and multiple microservices.
  tags:
    - development
    - vm
    - critical
  links:
    - url: https://console.vcenter.otxlab.net/ui#/vm/vm-1234
      title: vSphere Console
      icon: server
    - url: https://monitoring.otxlab.net/server/bp2-bkstdev-l001
      title: Monitoring Dashboard
      icon: dashboard
spec:
  type: server
  owner: group:pht-team/backstage-eng
  system: eng-tools/backstage
  domain: product/35968b13-c250-48e8-8309-5e5759b8fbcb
  serverType: virtual
  osType: linux
  osVersion: ubuntu-22.04
  dns:
    fqdn: bp2-bkstdev-l001.otxlab.net
    alts:
      - backstage-dev.otxlab.net
      - backstage-uat.otxlab.net
  ips:
    - address: 192.168.1.100
      type: ipv4
    - address: 2001:db8::100
      type: ipv6
  hardware:
    cpu: '16-core Intel Xeon'
    memory: '64GB DDR4'
    storage: '2TB SSD + 4TB HDD'
  networkInterfaces:
    - name: eth0
      ip: '192.168.1.100'
      gateway: '192.168.1.1'
      subnet: '255.255.255.0'
    - name: eth1
      ip: '10.0.0.100'
      gateway: '10.0.0.1'
      subnet: '255.255.255.0'
  location:
    dataCenter: us-east-1
    rack: R12
    slot: '42'
```

## Server Type Values

- `physical` - Physical hardware server
- `virtual` - Virtual machine (VMware, Hyper-V, KVM, etc.)
- `cloud-instance` - Cloud provider instance (AWS EC2, Azure VM, GCP Compute)
- `container-host` - Docker/container host
- `bare-metal` - Provisioned bare metal cloud instance

## OS Types

- `linux` - Linux distributions
- `windows` - Windows Server or Windows OS
- `macos` - macOS operating system
- `bsd` - BSD variants

## Related Resources

Servers typically host or connect with:

- **Databases** - Running on servers
- **Services/Applications** - Running on servers
- **Load Balancers** - Distributing traffic to servers
- **Network Equipment** - Managing server connectivity

## DNS Configuration

Servers are typically accessed via DNS names:

```yaml
spec:
  dns:
    fqdn: primary-hostname.domain.com
    alts:
      - alternate-name-1.domain.com
      - alternate-name-2.domain.com
```

The `fqdn` is the primary fully qualified domain name, and `alts` are alternative names.

## Tips

- FQDN (Fully Qualified Domain Name) is the primary identifier
- Alternative DNS names aid with service discovery
- Hardware specs help with capacity planning
- OS information aids with compatibility checking
- Network interface config supports multi-homed servers
- Location information is useful for physical inventory
- Multiple IP addresses support different networks/VLANs
- Use both IPv4 and IPv6 addresses if applicable
