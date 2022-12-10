# LV 사이즈 증설

---

### LV 사이즈 증설

논리 볼륨 cwking-lv1 및 파일 시스템의 크기를 250mib로 조정한다. 

파일 시스템 내용이 그대로 남아있는지 확인한다.

참고: 파티션은 정확히 동일한 크기가 요청되지 않으므로 225-275 범위내의 크기가 허용된다.

![Untitled](https://user-images.githubusercontent.com/84123877/206857276-25421cc2-b427-4ee7-aa7b-d23e075635b1.png)


```bash
[root@localhost ~]# df -h /cwMaster/
Filesystem              Size  Used Avail Use% Mounted on
/dev/mapper/cwking-lv1   70M   14K   64M   1% /cwMaster
[root@localhost ~]# echo '250 - 70' | bc
180
# 180m만 더 있으면 된다. 180m을 추가하겠다.

# pv, vg 정보 확인
[root@localhost ~]# pvs
  PV         VG     Fmt  Attr PSize    PFree  
  /dev/sda2  rl     lvm2 a--   <15.00g      0 
  /dev/sdb1  cwking lvm2 a--  1020.00m 940.00m
[root@localhost ~]# vgs
  VG     #PV #LV #SN Attr   VSize    VFree  
  cwking   1   1   0 wz--n- 1020.00m 940.00m
  rl       1   2   0 wz--n-  <15.00g

# 고정된 형식으로 vg, lv 속성 확인
[root@localhost ~]# vgdisplay cwking
  --- Volume group ---
  VG Name               cwking
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               1020.00 MiB
  PE Size               4.00 MiB
  Total PE              255
  Alloc PE / Size       20 / 80.00 MiB
  Free  PE / Size       235 / 940.00 MiB
  VG UUID               oq9Slg-i4UL-Pn9P-1Rc9-kNFg-EMIj-5biCe8
   
[root@localhost ~]# lvdisplay /dev/cwking/lv1
  --- Logical volume ---
  LV Path                /dev/cwking/lv1
  LV Name                lv1
  VG Name                cwking
  LV UUID                qDBXYW-6BGJ-KLfk-V04T-jkLJ-qZeh-HzYGAe
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2022-11-24 11:18:08 +0900
  LV Status              available
  # open                 1
  LV Size                80.00 MiB
  Current LE             20
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           253:2
   

# lv 증설 (+[크기] 로 추가, 혹은 아래 명령처럼 250m로 지정할 수 있다.)
[root@localhost home]# lvextend -L 250M /dev/cwking/lv1 
  Rounding size to boundary between physical extents: 252.00 MiB.
  Size of logical volume cwking/lv1 changed from 80.00 MiB (20 extents) to 252.00 MiB (63 extents).
  Logical volume cwking/lv1 successfully resized.
[root@localhost home]# lvs
  LV   VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  lv1  cwking -wi-ao---- 252.00m                                                    
  root rl     -wi-ao----  13.39g                                                    
  swap rl     -wi-ao----   1.60g                                                    

# mount 확인 (아직 미적용인 상태를 확인할 수 있다.)
[root@localhost home]# mount | grep cwMaster
/dev/mapper/cwking-lv1 on /cwMaster type ext4 (rw,relatime,seclabel)
[root@localhost home]# df -T /cwMaster
Filesystem             Type 1K-blocks  Used Available Use% Mounted on
/dev/mapper/cwking-lv1 ext4     71135    14     65387   1% /cwMaster

# resizefs 명령으로 적용한다.
[root@localhost home]# resize2fs /dev/cwking/lv1 
resize2fs 1.46.5 (30-Dec-2021)
Filesystem at /dev/cwking/lv1 is mounted on /cwMaster; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 2
The filesystem on /dev/cwking/lv1 is now 258048 (1k) blocks long.

# mount 적용 확인
[root@localhost home]# df -T /cwMaster
Filesystem             Type 1K-blocks  Used Available Use% Mounted on
/dev/mapper/cwking-lv1 ext4    237479  2054    222646   1% /cwMaster
[root@localhost home]#
```

### + 추가1

df -T로 파일시스템을 확인하였을 때 xfs로 출력이 된다면 xfs_grouwfs 로 실행해야 함.

```bash
xfs_grouwfs /cwMaster
df /cwMaster
```

### + 추가2

![Untitled 1](https://user-images.githubusercontent.com/84123877/206857272-b9b3af50-8f0c-492b-8f00-e1f529f74412.png)


-l +3 으로 3%를 추가할 수 있으며, 용량 옆 가로에 (63 extents) 등으로 현재 퍼센트가 나타난다.

---
