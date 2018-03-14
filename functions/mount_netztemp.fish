function mount_netztemp --description 'Mounts the Trust netztemp samba share to /mnt/netztemp'
  command sudo mount -t cifs -o 'domain=TRUST,user=kmoschcau,vers=1.0' //frafileserver1/netztemp/ /mnt/netztemp/
end
