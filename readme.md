# redis cluster

see 

```sh
make help
```


redis-cluster


```
                          #############
                              Load
                            Balancer
                          #############
                                |
      __________________________|_________________________
      |                         |                        |
      V                         V                        V
     VM1                       VM2                      VM3
#############             #############             #############
redis-1                   redis-2                   redis-3
master [R/W]              master [R/W]              master [R/W]
#############             #############             #############
      |                         |                         |
      |                         |                         |
      V                         V                         V
#############             #############             #############
redis-5                   redis-6                   redis-4
slave [R]                 slave [R]                 slave [R]
#############             #############             #############
```

testing:
....

When 1 or 2 VMs go down, the rest can still provide service.