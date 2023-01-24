
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}


int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	31 f6                	xor    %esi,%esi
  11:	53                   	push   %ebx
  12:	bb 01 00 00 00       	mov    $0x1,%ebx
  17:	51                   	push   %ecx
  18:	83 ec 18             	sub    $0x18,%esp
  1b:	8b 01                	mov    (%ecx),%eax
  1d:	8b 79 04             	mov    0x4(%ecx),%edi
  20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int i;

  if(argc < 2){
  23:	83 f8 01             	cmp    $0x1,%eax
  26:	7e 58                	jle    80 <main+0x80>
  28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop
    exit();
  }

  int flag = 0; 	
  for(i=1; i<argc; i++){
	  if(strcmp(argv[i], "-a") == 0) {
  30:	83 ec 08             	sub    $0x8,%esp
  33:	68 7f 0d 00 00       	push   $0xd7f
  38:	ff 34 9f             	push   (%edi,%ebx,4)
  3b:	e8 30 06 00 00       	call   670 <strcmp>
  40:	83 c4 10             	add    $0x10,%esp
		flag = 1; 
  43:	85 c0                	test   %eax,%eax
  45:	b8 01 00 00 00       	mov    $0x1,%eax
  4a:	0f 44 f0             	cmove  %eax,%esi
  for(i=1; i<argc; i++){
  4d:	83 c3 01             	add    $0x1,%ebx
  50:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
  53:	75 db                	jne    30 <main+0x30>
	  }
  }


  if(flag == 0){
  55:	85 f6                	test   %esi,%esi
  57:	74 15                	je     6e <main+0x6e>
    ls(".");
  }

  else {
        ls_a(".");
  59:	83 ec 0c             	sub    $0xc,%esp
  5c:	68 7d 0d 00 00       	push   $0xd7d
  61:	e8 3a 03 00 00       	call   3a0 <ls_a>
  66:	83 c4 10             	add    $0x10,%esp





  exit();
  69:	e8 25 08 00 00       	call   893 <exit>
    ls(".");
  6e:	83 ec 0c             	sub    $0xc,%esp
  71:	68 7d 0d 00 00       	push   $0xd7d
  76:	e8 95 00 00 00       	call   110 <ls>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	eb e9                	jmp    69 <main+0x69>
    ls(".");
  80:	83 ec 0c             	sub    $0xc,%esp
  83:	68 7d 0d 00 00       	push   $0xd7d
  88:	e8 83 00 00 00       	call   110 <ls>
    exit();
  8d:	e8 01 08 00 00       	call   893 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <fmtname>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	56                   	push   %esi
  a4:	53                   	push   %ebx
  a5:	8b 75 08             	mov    0x8(%ebp),%esi
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  a8:	83 ec 0c             	sub    $0xc,%esp
  ab:	56                   	push   %esi
  ac:	e8 1f 06 00 00       	call   6d0 <strlen>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	01 f0                	add    %esi,%eax
  b6:	89 c3                	mov    %eax,%ebx
  b8:	73 0f                	jae    c9 <fmtname+0x29>
  ba:	eb 12                	jmp    ce <fmtname+0x2e>
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  c3:	39 c6                	cmp    %eax,%esi
  c5:	77 0a                	ja     d1 <fmtname+0x31>
  c7:	89 c3                	mov    %eax,%ebx
  c9:	80 3b 2f             	cmpb   $0x2f,(%ebx)
  cc:	75 f2                	jne    c0 <fmtname+0x20>
  p++;
  ce:	83 c3 01             	add    $0x1,%ebx
  if(strlen(p) >= DIRSIZ)
  d1:	83 ec 0c             	sub    $0xc,%esp
  d4:	53                   	push   %ebx
  d5:	e8 f6 05 00 00       	call   6d0 <strlen>
  da:	83 c4 10             	add    $0x10,%esp
  dd:	83 f8 0d             	cmp    $0xd,%eax
  e0:	77 20                	ja     102 <fmtname+0x62>
  memmove(buf, p, strlen(p));
  e2:	83 ec 0c             	sub    $0xc,%esp
  e5:	53                   	push   %ebx
  e6:	e8 e5 05 00 00       	call   6d0 <strlen>
  eb:	83 c4 0c             	add    $0xc,%esp
  ee:	50                   	push   %eax
  ef:	53                   	push   %ebx
  return buf;
  f0:	bb 64 11 00 00       	mov    $0x1164,%ebx
  memmove(buf, p, strlen(p));
  f5:	68 64 11 00 00       	push   $0x1164
  fa:	e8 61 07 00 00       	call   860 <memmove>
  return buf;
  ff:	83 c4 10             	add    $0x10,%esp
}
 102:	8d 65 f8             	lea    -0x8(%ebp),%esp
 105:	89 d8                	mov    %ebx,%eax
 107:	5b                   	pop    %ebx
 108:	5e                   	pop    %esi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <ls>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
 116:	81 ec 64 02 00 00    	sub    $0x264,%esp
 11c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 11f:	6a 00                	push   $0x0
 121:	57                   	push   %edi
 122:	e8 ac 07 00 00       	call   8d3 <open>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	85 c0                	test   %eax,%eax
 12c:	0f 88 ae 01 00 00    	js     2e0 <ls+0x1d0>
  if(fstat(fd, &st) < 0){
 132:	83 ec 08             	sub    $0x8,%esp
 135:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 13b:	89 c3                	mov    %eax,%ebx
 13d:	56                   	push   %esi
 13e:	50                   	push   %eax
 13f:	e8 a7 07 00 00       	call   8eb <fstat>
 144:	83 c4 10             	add    $0x10,%esp
 147:	85 c0                	test   %eax,%eax
 149:	0f 88 d1 01 00 00    	js     320 <ls+0x210>
  switch(st.type){
 14f:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 156:	66 83 f8 01          	cmp    $0x1,%ax
 15a:	74 64                	je     1c0 <ls+0xb0>
 15c:	66 83 f8 02          	cmp    $0x2,%ax
 160:	74 1e                	je     180 <ls+0x70>
  close(fd);
 162:	83 ec 0c             	sub    $0xc,%esp
 165:	53                   	push   %ebx
 166:	e8 50 07 00 00       	call   8bb <close>
 16b:	83 c4 10             	add    $0x10,%esp
}
 16e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 171:	5b                   	pop    %ebx
 172:	5e                   	pop    %esi
 173:	5f                   	pop    %edi
 174:	5d                   	pop    %ebp
 175:	c3                   	ret    
 176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 180:	83 ec 0c             	sub    $0xc,%esp
 183:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 189:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 18f:	57                   	push   %edi
 190:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 196:	e8 05 ff ff ff       	call   a0 <fmtname>
 19b:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 1a1:	59                   	pop    %ecx
 1a2:	5f                   	pop    %edi
 1a3:	52                   	push   %edx
 1a4:	56                   	push   %esi
 1a5:	6a 02                	push   $0x2
 1a7:	50                   	push   %eax
 1a8:	68 40 0d 00 00       	push   $0xd40
 1ad:	6a 01                	push   $0x1
 1af:	e8 3c 08 00 00       	call   9f0 <printf>
    break;
 1b4:	83 c4 20             	add    $0x20,%esp
 1b7:	eb a9                	jmp    162 <ls+0x52>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c0:	83 ec 0c             	sub    $0xc,%esp
 1c3:	57                   	push   %edi
 1c4:	e8 07 05 00 00       	call   6d0 <strlen>
 1c9:	83 c4 10             	add    $0x10,%esp
 1cc:	83 c0 10             	add    $0x10,%eax
 1cf:	3d 00 02 00 00       	cmp    $0x200,%eax
 1d4:	0f 87 26 01 00 00    	ja     300 <ls+0x1f0>
    strcpy(buf, path);
 1da:	83 ec 08             	sub    $0x8,%esp
 1dd:	57                   	push   %edi
 1de:	8d bd e8 fd ff ff    	lea    -0x218(%ebp),%edi
 1e4:	57                   	push   %edi
 1e5:	e8 56 04 00 00       	call   640 <strcpy>
    p = buf+strlen(buf);
 1ea:	89 3c 24             	mov    %edi,(%esp)
 1ed:	e8 de 04 00 00       	call   6d0 <strlen>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f2:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1f5:	01 f8                	add    %edi,%eax
    *p++ = '/';
 1f7:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 1fa:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 200:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 206:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 210:	83 ec 04             	sub    $0x4,%esp
 213:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 219:	6a 10                	push   $0x10
 21b:	50                   	push   %eax
 21c:	53                   	push   %ebx
 21d:	e8 89 06 00 00       	call   8ab <read>
 222:	83 c4 10             	add    $0x10,%esp
 225:	83 f8 10             	cmp    $0x10,%eax
 228:	0f 85 34 ff ff ff    	jne    162 <ls+0x52>
      if(de.inum == 0)
 22e:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 235:	00 
 236:	74 d8                	je     210 <ls+0x100>
      memmove(p, de.name, DIRSIZ);
 238:	83 ec 04             	sub    $0x4,%esp
 23b:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 241:	6a 0e                	push   $0xe
 243:	50                   	push   %eax
 244:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
 24a:	e8 11 06 00 00       	call   860 <memmove>
      p[DIRSIZ] = 0;
 24f:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 255:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 259:	58                   	pop    %eax
 25a:	5a                   	pop    %edx
 25b:	56                   	push   %esi
 25c:	57                   	push   %edi
 25d:	e8 6e 05 00 00       	call   7d0 <stat>
 262:	83 c4 10             	add    $0x10,%esp
 265:	85 c0                	test   %eax,%eax
 267:	0f 88 13 01 00 00    	js     380 <ls+0x270>
      if (de.name[0] != '.'){
 26d:	80 bd c6 fd ff ff 2e 	cmpb   $0x2e,-0x23a(%ebp)
 274:	74 9a                	je     210 <ls+0x100>
	printf(1, "%s/\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);      	
 276:	8b 85 dc fd ff ff    	mov    -0x224(%ebp),%eax
      if (st.type == 1){
 27c:	0f b7 95 d4 fd ff ff 	movzwl -0x22c(%ebp),%edx
	printf(1, "%s/\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);      	
 283:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 289:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
      if (st.type == 1){
 28f:	66 83 fa 01          	cmp    $0x1,%dx
 293:	0f 84 af 00 00 00    	je     348 <ls+0x238>
      	printf(1, "%s\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 299:	83 ec 0c             	sub    $0xc,%esp
 29c:	89 95 a4 fd ff ff    	mov    %edx,-0x25c(%ebp)
 2a2:	57                   	push   %edi
 2a3:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 2a9:	e8 f2 fd ff ff       	call   a0 <fmtname>
 2ae:	5a                   	pop    %edx
 2af:	8b 95 a4 fd ff ff    	mov    -0x25c(%ebp),%edx
 2b5:	59                   	pop    %ecx
 2b6:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 2bc:	0f bf d2             	movswl %dx,%edx
 2bf:	51                   	push   %ecx
 2c0:	ff b5 ac fd ff ff    	push   -0x254(%ebp)
 2c6:	52                   	push   %edx
 2c7:	50                   	push   %eax
 2c8:	68 6f 0d 00 00       	push   $0xd6f
 2cd:	6a 01                	push   $0x1
 2cf:	e8 1c 07 00 00       	call   9f0 <printf>
 2d4:	83 c4 20             	add    $0x20,%esp
 2d7:	e9 34 ff ff ff       	jmp    210 <ls+0x100>
 2dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	57                   	push   %edi
 2e4:	68 18 0d 00 00       	push   $0xd18
 2e9:	6a 02                	push   $0x2
 2eb:	e8 00 07 00 00       	call   9f0 <printf>
    return;
 2f0:	83 c4 10             	add    $0x10,%esp
}
 2f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2f6:	5b                   	pop    %ebx
 2f7:	5e                   	pop    %esi
 2f8:	5f                   	pop    %edi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    
 2fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2ff:	90                   	nop
      printf(1, "ls: path too long\n");
 300:	83 ec 08             	sub    $0x8,%esp
 303:	68 4d 0d 00 00       	push   $0xd4d
 308:	6a 01                	push   $0x1
 30a:	e8 e1 06 00 00       	call   9f0 <printf>
      break;
 30f:	83 c4 10             	add    $0x10,%esp
 312:	e9 4b fe ff ff       	jmp    162 <ls+0x52>
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax
    printf(2, "ls: cannot stat %s\n", path);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	57                   	push   %edi
 324:	68 2c 0d 00 00       	push   $0xd2c
 329:	6a 02                	push   $0x2
 32b:	e8 c0 06 00 00       	call   9f0 <printf>
    close(fd);
 330:	89 1c 24             	mov    %ebx,(%esp)
 333:	e8 83 05 00 00       	call   8bb <close>
    return;
 338:	83 c4 10             	add    $0x10,%esp
}
 33b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 33e:	5b                   	pop    %ebx
 33f:	5e                   	pop    %esi
 340:	5f                   	pop    %edi
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
 343:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 347:	90                   	nop
	printf(1, "%s/\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);      	
 348:	83 ec 0c             	sub    $0xc,%esp
 34b:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 351:	57                   	push   %edi
 352:	e8 49 fd ff ff       	call   a0 <fmtname>
 357:	5a                   	pop    %edx
 358:	59                   	pop    %ecx
 359:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 35f:	51                   	push   %ecx
 360:	ff b5 ac fd ff ff    	push   -0x254(%ebp)
 366:	6a 01                	push   $0x1
 368:	50                   	push   %eax
 369:	68 60 0d 00 00       	push   $0xd60
 36e:	6a 01                	push   $0x1
 370:	e8 7b 06 00 00       	call   9f0 <printf>
 375:	83 c4 20             	add    $0x20,%esp
 378:	e9 93 fe ff ff       	jmp    210 <ls+0x100>
 37d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 380:	83 ec 04             	sub    $0x4,%esp
 383:	57                   	push   %edi
 384:	68 2c 0d 00 00       	push   $0xd2c
 389:	6a 01                	push   $0x1
 38b:	e8 60 06 00 00       	call   9f0 <printf>
        continue;
 390:	83 c4 10             	add    $0x10,%esp
 393:	e9 78 fe ff ff       	jmp    210 <ls+0x100>
 398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop

000003a0 <ls_a>:
ls_a(char* path){
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	81 ec 54 02 00 00    	sub    $0x254,%esp
 3ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 3af:	6a 00                	push   $0x0
 3b1:	57                   	push   %edi
 3b2:	e8 1c 05 00 00       	call   8d3 <open>
 3b7:	83 c4 10             	add    $0x10,%esp
 3ba:	85 c0                	test   %eax,%eax
 3bc:	0f 88 b6 01 00 00    	js     578 <ls_a+0x1d8>
  if(fstat(fd, &st) < 0){
 3c2:	83 ec 08             	sub    $0x8,%esp
 3c5:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 3cb:	89 c3                	mov    %eax,%ebx
 3cd:	56                   	push   %esi
 3ce:	50                   	push   %eax
 3cf:	e8 17 05 00 00       	call   8eb <fstat>
 3d4:	83 c4 10             	add    $0x10,%esp
 3d7:	85 c0                	test   %eax,%eax
 3d9:	0f 88 d1 01 00 00    	js     5b0 <ls_a+0x210>
  switch(st.type){
 3df:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 3e6:	66 83 f8 01          	cmp    $0x1,%ax
 3ea:	74 64                	je     450 <ls_a+0xb0>
 3ec:	66 83 f8 02          	cmp    $0x2,%ax
 3f0:	74 1e                	je     410 <ls_a+0x70>
   close(fd);
 3f2:	83 ec 0c             	sub    $0xc,%esp
 3f5:	53                   	push   %ebx
 3f6:	e8 c0 04 00 00       	call   8bb <close>
 3fb:	83 c4 10             	add    $0x10,%esp
}
 3fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
 401:	5b                   	pop    %ebx
 402:	5e                   	pop    %esi
 403:	5f                   	pop    %edi
 404:	5d                   	pop    %ebp
 405:	c3                   	ret    
 406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 410:	83 ec 0c             	sub    $0xc,%esp
 413:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 419:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 41f:	57                   	push   %edi
 420:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 426:	e8 75 fc ff ff       	call   a0 <fmtname>
 42b:	5a                   	pop    %edx
 42c:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 432:	59                   	pop    %ecx
 433:	52                   	push   %edx
 434:	56                   	push   %esi
 435:	6a 02                	push   $0x2
 437:	50                   	push   %eax
 438:	68 40 0d 00 00       	push   $0xd40
 43d:	6a 01                	push   $0x1
 43f:	e8 ac 05 00 00       	call   9f0 <printf>
    break;
 444:	83 c4 20             	add    $0x20,%esp
 447:	eb a9                	jmp    3f2 <ls_a+0x52>
 449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 450:	83 ec 0c             	sub    $0xc,%esp
 453:	57                   	push   %edi
 454:	e8 77 02 00 00       	call   6d0 <strlen>
 459:	83 c4 10             	add    $0x10,%esp
 45c:	83 c0 10             	add    $0x10,%eax
 45f:	3d 00 02 00 00       	cmp    $0x200,%eax
 464:	0f 87 2e 01 00 00    	ja     598 <ls_a+0x1f8>
    strcpy(buf, path);
 46a:	83 ec 08             	sub    $0x8,%esp
 46d:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 473:	57                   	push   %edi
 474:	50                   	push   %eax
 475:	e8 c6 01 00 00       	call   640 <strcpy>
    p = buf+strlen(buf);
 47a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 480:	89 04 24             	mov    %eax,(%esp)
 483:	e8 48 02 00 00       	call   6d0 <strlen>
 488:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 48e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 491:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 493:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 496:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 49c:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 4a2:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 4a5:	8d 76 00             	lea    0x0(%esi),%esi
 4a8:	83 ec 04             	sub    $0x4,%esp
 4ab:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 4b1:	6a 10                	push   $0x10
 4b3:	50                   	push   %eax
 4b4:	53                   	push   %ebx
 4b5:	e8 f1 03 00 00       	call   8ab <read>
 4ba:	83 c4 10             	add    $0x10,%esp
 4bd:	83 f8 10             	cmp    $0x10,%eax
 4c0:	0f 85 2c ff ff ff    	jne    3f2 <ls_a+0x52>
      if(de.inum == 0)
 4c6:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 4cd:	00 
 4ce:	74 d8                	je     4a8 <ls_a+0x108>
      memmove(p, de.name, DIRSIZ);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 4d9:	6a 0e                	push   $0xe
 4db:	50                   	push   %eax
 4dc:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
 4e2:	e8 79 03 00 00       	call   860 <memmove>
      p[DIRSIZ] = 0;
 4e7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 4ed:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 4f1:	5f                   	pop    %edi
 4f2:	58                   	pop    %eax
 4f3:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 4f9:	56                   	push   %esi
 4fa:	50                   	push   %eax
 4fb:	e8 d0 02 00 00       	call   7d0 <stat>
 500:	83 c4 10             	add    $0x10,%esp
 503:	85 c0                	test   %eax,%eax
 505:	0f 88 15 01 00 00    	js     620 <ls_a+0x280>
      if (st.type == 1){
 50b:	0f bf bd d4 fd ff ff 	movswl -0x22c(%ebp),%edi
 512:	66 83 ff 01          	cmp    $0x1,%di
 516:	0f 84 bc 00 00 00    	je     5d8 <ls_a+0x238>
      else if (st.type==2 || st.type==3){
 51c:	8d 47 fe             	lea    -0x2(%edi),%eax
 51f:	66 83 f8 01          	cmp    $0x1,%ax
 523:	77 83                	ja     4a8 <ls_a+0x108>
        printf(1, "%s\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 525:	83 ec 0c             	sub    $0xc,%esp
 528:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 52e:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 534:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 53a:	50                   	push   %eax
 53b:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 541:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 547:	e8 54 fb ff ff       	call   a0 <fmtname>
 54c:	5a                   	pop    %edx
 54d:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 553:	59                   	pop    %ecx
 554:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 55a:	51                   	push   %ecx
 55b:	52                   	push   %edx
 55c:	57                   	push   %edi
 55d:	50                   	push   %eax
 55e:	68 6f 0d 00 00       	push   $0xd6f
 563:	6a 01                	push   $0x1
 565:	e8 86 04 00 00       	call   9f0 <printf>
 56a:	83 c4 20             	add    $0x20,%esp
 56d:	e9 36 ff ff ff       	jmp    4a8 <ls_a+0x108>
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 578:	83 ec 04             	sub    $0x4,%esp
 57b:	57                   	push   %edi
 57c:	68 18 0d 00 00       	push   $0xd18
 581:	6a 02                	push   $0x2
 583:	e8 68 04 00 00       	call   9f0 <printf>
    return;
 588:	83 c4 10             	add    $0x10,%esp
}
 58b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58e:	5b                   	pop    %ebx
 58f:	5e                   	pop    %esi
 590:	5f                   	pop    %edi
 591:	5d                   	pop    %ebp
 592:	c3                   	ret    
 593:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 597:	90                   	nop
      printf(1, "ls: path too long\n");
 598:	83 ec 08             	sub    $0x8,%esp
 59b:	68 4d 0d 00 00       	push   $0xd4d
 5a0:	6a 01                	push   $0x1
 5a2:	e8 49 04 00 00       	call   9f0 <printf>
      break;
 5a7:	83 c4 10             	add    $0x10,%esp
 5aa:	e9 43 fe ff ff       	jmp    3f2 <ls_a+0x52>
 5af:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	57                   	push   %edi
 5b4:	68 2c 0d 00 00       	push   $0xd2c
 5b9:	6a 02                	push   $0x2
 5bb:	e8 30 04 00 00       	call   9f0 <printf>
    close(fd);
 5c0:	89 1c 24             	mov    %ebx,(%esp)
 5c3:	e8 f3 02 00 00       	call   8bb <close>
    return;
 5c8:	83 c4 10             	add    $0x10,%esp
}
 5cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ce:	5b                   	pop    %ebx
 5cf:	5e                   	pop    %esi
 5d0:	5f                   	pop    %edi
 5d1:	5d                   	pop    %ebp
 5d2:	c3                   	ret    
 5d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d7:	90                   	nop
        printf(1, "%s/\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 5d8:	83 ec 0c             	sub    $0xc,%esp
 5db:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5e1:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 5e7:	8b bd dc fd ff ff    	mov    -0x224(%ebp),%edi
 5ed:	50                   	push   %eax
 5ee:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 5f4:	e8 a7 fa ff ff       	call   a0 <fmtname>
 5f9:	5a                   	pop    %edx
 5fa:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 600:	59                   	pop    %ecx
 601:	52                   	push   %edx
 602:	57                   	push   %edi
 603:	6a 01                	push   $0x1
 605:	50                   	push   %eax
 606:	68 60 0d 00 00       	push   $0xd60
 60b:	6a 01                	push   $0x1
 60d:	e8 de 03 00 00       	call   9f0 <printf>
 612:	83 c4 20             	add    $0x20,%esp
 615:	e9 8e fe ff ff       	jmp    4a8 <ls_a+0x108>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 620:	83 ec 04             	sub    $0x4,%esp
 623:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 629:	50                   	push   %eax
 62a:	68 2c 0d 00 00       	push   $0xd2c
 62f:	6a 01                	push   $0x1
 631:	e8 ba 03 00 00       	call   9f0 <printf>
        continue;
 636:	83 c4 10             	add    $0x10,%esp
 639:	e9 6a fe ff ff       	jmp    4a8 <ls_a+0x108>
 63e:	66 90                	xchg   %ax,%ax

00000640 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 640:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 641:	31 c0                	xor    %eax,%eax
{
 643:	89 e5                	mov    %esp,%ebp
 645:	53                   	push   %ebx
 646:	8b 4d 08             	mov    0x8(%ebp),%ecx
 649:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 650:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 654:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 657:	83 c0 01             	add    $0x1,%eax
 65a:	84 d2                	test   %dl,%dl
 65c:	75 f2                	jne    650 <strcpy+0x10>
    ;
  return os;
}
 65e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 661:	89 c8                	mov    %ecx,%eax
 663:	c9                   	leave  
 664:	c3                   	ret    
 665:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	53                   	push   %ebx
 674:	8b 55 08             	mov    0x8(%ebp),%edx
 677:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 67a:	0f b6 02             	movzbl (%edx),%eax
 67d:	84 c0                	test   %al,%al
 67f:	75 17                	jne    698 <strcmp+0x28>
 681:	eb 3a                	jmp    6bd <strcmp+0x4d>
 683:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 687:	90                   	nop
 688:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 68c:	83 c2 01             	add    $0x1,%edx
 68f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 692:	84 c0                	test   %al,%al
 694:	74 1a                	je     6b0 <strcmp+0x40>
    p++, q++;
 696:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 698:	0f b6 19             	movzbl (%ecx),%ebx
 69b:	38 c3                	cmp    %al,%bl
 69d:	74 e9                	je     688 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 69f:	29 d8                	sub    %ebx,%eax
}
 6a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6a4:	c9                   	leave  
 6a5:	c3                   	ret    
 6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 6b0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 6b4:	31 c0                	xor    %eax,%eax
 6b6:	29 d8                	sub    %ebx,%eax
}
 6b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6bb:	c9                   	leave  
 6bc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 6bd:	0f b6 19             	movzbl (%ecx),%ebx
 6c0:	31 c0                	xor    %eax,%eax
 6c2:	eb db                	jmp    69f <strcmp+0x2f>
 6c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop

000006d0 <strlen>:

uint
strlen(const char *s)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 6d6:	80 3a 00             	cmpb   $0x0,(%edx)
 6d9:	74 15                	je     6f0 <strlen+0x20>
 6db:	31 c0                	xor    %eax,%eax
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
 6e0:	83 c0 01             	add    $0x1,%eax
 6e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 6e7:	89 c1                	mov    %eax,%ecx
 6e9:	75 f5                	jne    6e0 <strlen+0x10>
    ;
  return n;
}
 6eb:	89 c8                	mov    %ecx,%eax
 6ed:	5d                   	pop    %ebp
 6ee:	c3                   	ret    
 6ef:	90                   	nop
  for(n = 0; s[n]; n++)
 6f0:	31 c9                	xor    %ecx,%ecx
}
 6f2:	5d                   	pop    %ebp
 6f3:	89 c8                	mov    %ecx,%eax
 6f5:	c3                   	ret    
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi

00000700 <memset>:

void*
memset(void *dst, int c, uint n)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 707:	8b 4d 10             	mov    0x10(%ebp),%ecx
 70a:	8b 45 0c             	mov    0xc(%ebp),%eax
 70d:	89 d7                	mov    %edx,%edi
 70f:	fc                   	cld    
 710:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 712:	8b 7d fc             	mov    -0x4(%ebp),%edi
 715:	89 d0                	mov    %edx,%eax
 717:	c9                   	leave  
 718:	c3                   	ret    
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000720 <strchr>:

char*
strchr(const char *s, char c)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	8b 45 08             	mov    0x8(%ebp),%eax
 726:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 72a:	0f b6 10             	movzbl (%eax),%edx
 72d:	84 d2                	test   %dl,%dl
 72f:	75 12                	jne    743 <strchr+0x23>
 731:	eb 1d                	jmp    750 <strchr+0x30>
 733:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 737:	90                   	nop
 738:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 73c:	83 c0 01             	add    $0x1,%eax
 73f:	84 d2                	test   %dl,%dl
 741:	74 0d                	je     750 <strchr+0x30>
    if(*s == c)
 743:	38 d1                	cmp    %dl,%cl
 745:	75 f1                	jne    738 <strchr+0x18>
      return (char*)s;
  return 0;
}
 747:	5d                   	pop    %ebp
 748:	c3                   	ret    
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 750:	31 c0                	xor    %eax,%eax
}
 752:	5d                   	pop    %ebp
 753:	c3                   	ret    
 754:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop

00000760 <gets>:

char*
gets(char *buf, int max)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 765:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 768:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 769:	31 db                	xor    %ebx,%ebx
{
 76b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 76e:	eb 27                	jmp    797 <gets+0x37>
    cc = read(0, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	6a 01                	push   $0x1
 775:	57                   	push   %edi
 776:	6a 00                	push   $0x0
 778:	e8 2e 01 00 00       	call   8ab <read>
    if(cc < 1)
 77d:	83 c4 10             	add    $0x10,%esp
 780:	85 c0                	test   %eax,%eax
 782:	7e 1d                	jle    7a1 <gets+0x41>
      break;
    buf[i++] = c;
 784:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 788:	8b 55 08             	mov    0x8(%ebp),%edx
 78b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 78f:	3c 0a                	cmp    $0xa,%al
 791:	74 1d                	je     7b0 <gets+0x50>
 793:	3c 0d                	cmp    $0xd,%al
 795:	74 19                	je     7b0 <gets+0x50>
  for(i=0; i+1 < max; ){
 797:	89 de                	mov    %ebx,%esi
 799:	83 c3 01             	add    $0x1,%ebx
 79c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 79f:	7c cf                	jl     770 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 7a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7ab:	5b                   	pop    %ebx
 7ac:	5e                   	pop    %esi
 7ad:	5f                   	pop    %edi
 7ae:	5d                   	pop    %ebp
 7af:	c3                   	ret    
  buf[i] = '\0';
 7b0:	8b 45 08             	mov    0x8(%ebp),%eax
 7b3:	89 de                	mov    %ebx,%esi
 7b5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 7b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7bc:	5b                   	pop    %ebx
 7bd:	5e                   	pop    %esi
 7be:	5f                   	pop    %edi
 7bf:	5d                   	pop    %ebp
 7c0:	c3                   	ret    
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7cf:	90                   	nop

000007d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	56                   	push   %esi
 7d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 7d5:	83 ec 08             	sub    $0x8,%esp
 7d8:	6a 00                	push   $0x0
 7da:	ff 75 08             	push   0x8(%ebp)
 7dd:	e8 f1 00 00 00       	call   8d3 <open>
  if(fd < 0)
 7e2:	83 c4 10             	add    $0x10,%esp
 7e5:	85 c0                	test   %eax,%eax
 7e7:	78 27                	js     810 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 7e9:	83 ec 08             	sub    $0x8,%esp
 7ec:	ff 75 0c             	push   0xc(%ebp)
 7ef:	89 c3                	mov    %eax,%ebx
 7f1:	50                   	push   %eax
 7f2:	e8 f4 00 00 00       	call   8eb <fstat>
  close(fd);
 7f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 7fa:	89 c6                	mov    %eax,%esi
  close(fd);
 7fc:	e8 ba 00 00 00       	call   8bb <close>
  return r;
 801:	83 c4 10             	add    $0x10,%esp
}
 804:	8d 65 f8             	lea    -0x8(%ebp),%esp
 807:	89 f0                	mov    %esi,%eax
 809:	5b                   	pop    %ebx
 80a:	5e                   	pop    %esi
 80b:	5d                   	pop    %ebp
 80c:	c3                   	ret    
 80d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 810:	be ff ff ff ff       	mov    $0xffffffff,%esi
 815:	eb ed                	jmp    804 <stat+0x34>
 817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 81e:	66 90                	xchg   %ax,%ax

00000820 <atoi>:

int
atoi(const char *s)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	53                   	push   %ebx
 824:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 827:	0f be 02             	movsbl (%edx),%eax
 82a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 82d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 830:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 835:	77 1e                	ja     855 <atoi+0x35>
 837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 840:	83 c2 01             	add    $0x1,%edx
 843:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 846:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 84a:	0f be 02             	movsbl (%edx),%eax
 84d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 850:	80 fb 09             	cmp    $0x9,%bl
 853:	76 eb                	jbe    840 <atoi+0x20>
  return n;
}
 855:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 858:	89 c8                	mov    %ecx,%eax
 85a:	c9                   	leave  
 85b:	c3                   	ret    
 85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000860 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	8b 45 10             	mov    0x10(%ebp),%eax
 867:	8b 55 08             	mov    0x8(%ebp),%edx
 86a:	56                   	push   %esi
 86b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 86e:	85 c0                	test   %eax,%eax
 870:	7e 13                	jle    885 <memmove+0x25>
 872:	01 d0                	add    %edx,%eax
  dst = vdst;
 874:	89 d7                	mov    %edx,%edi
 876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 880:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 881:	39 f8                	cmp    %edi,%eax
 883:	75 fb                	jne    880 <memmove+0x20>
  return vdst;
}
 885:	5e                   	pop    %esi
 886:	89 d0                	mov    %edx,%eax
 888:	5f                   	pop    %edi
 889:	5d                   	pop    %ebp
 88a:	c3                   	ret    

0000088b <fork>:
 88b:	b8 01 00 00 00       	mov    $0x1,%eax
 890:	cd 40                	int    $0x40
 892:	c3                   	ret    

00000893 <exit>:
 893:	b8 02 00 00 00       	mov    $0x2,%eax
 898:	cd 40                	int    $0x40
 89a:	c3                   	ret    

0000089b <wait>:
 89b:	b8 03 00 00 00       	mov    $0x3,%eax
 8a0:	cd 40                	int    $0x40
 8a2:	c3                   	ret    

000008a3 <pipe>:
 8a3:	b8 04 00 00 00       	mov    $0x4,%eax
 8a8:	cd 40                	int    $0x40
 8aa:	c3                   	ret    

000008ab <read>:
 8ab:	b8 05 00 00 00       	mov    $0x5,%eax
 8b0:	cd 40                	int    $0x40
 8b2:	c3                   	ret    

000008b3 <write>:
 8b3:	b8 10 00 00 00       	mov    $0x10,%eax
 8b8:	cd 40                	int    $0x40
 8ba:	c3                   	ret    

000008bb <close>:
 8bb:	b8 15 00 00 00       	mov    $0x15,%eax
 8c0:	cd 40                	int    $0x40
 8c2:	c3                   	ret    

000008c3 <kill>:
 8c3:	b8 06 00 00 00       	mov    $0x6,%eax
 8c8:	cd 40                	int    $0x40
 8ca:	c3                   	ret    

000008cb <exec>:
 8cb:	b8 07 00 00 00       	mov    $0x7,%eax
 8d0:	cd 40                	int    $0x40
 8d2:	c3                   	ret    

000008d3 <open>:
 8d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 8d8:	cd 40                	int    $0x40
 8da:	c3                   	ret    

000008db <mknod>:
 8db:	b8 11 00 00 00       	mov    $0x11,%eax
 8e0:	cd 40                	int    $0x40
 8e2:	c3                   	ret    

000008e3 <unlink>:
 8e3:	b8 12 00 00 00       	mov    $0x12,%eax
 8e8:	cd 40                	int    $0x40
 8ea:	c3                   	ret    

000008eb <fstat>:
 8eb:	b8 08 00 00 00       	mov    $0x8,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    

000008f3 <link>:
 8f3:	b8 13 00 00 00       	mov    $0x13,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret    

000008fb <mkdir>:
 8fb:	b8 14 00 00 00       	mov    $0x14,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret    

00000903 <chdir>:
 903:	b8 09 00 00 00       	mov    $0x9,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret    

0000090b <dup>:
 90b:	b8 0a 00 00 00       	mov    $0xa,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret    

00000913 <getpid>:
 913:	b8 0b 00 00 00       	mov    $0xb,%eax
 918:	cd 40                	int    $0x40
 91a:	c3                   	ret    

0000091b <sbrk>:
 91b:	b8 0c 00 00 00       	mov    $0xc,%eax
 920:	cd 40                	int    $0x40
 922:	c3                   	ret    

00000923 <sleep>:
 923:	b8 0d 00 00 00       	mov    $0xd,%eax
 928:	cd 40                	int    $0x40
 92a:	c3                   	ret    

0000092b <uptime>:
 92b:	b8 0e 00 00 00       	mov    $0xe,%eax
 930:	cd 40                	int    $0x40
 932:	c3                   	ret    
 933:	66 90                	xchg   %ax,%ax
 935:	66 90                	xchg   %ax,%ax
 937:	66 90                	xchg   %ax,%ax
 939:	66 90                	xchg   %ax,%ax
 93b:	66 90                	xchg   %ax,%ax
 93d:	66 90                	xchg   %ax,%ax
 93f:	90                   	nop

00000940 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	57                   	push   %edi
 944:	56                   	push   %esi
 945:	53                   	push   %ebx
 946:	83 ec 3c             	sub    $0x3c,%esp
 949:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 94c:	89 d1                	mov    %edx,%ecx
{
 94e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 951:	85 d2                	test   %edx,%edx
 953:	0f 89 7f 00 00 00    	jns    9d8 <printint+0x98>
 959:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 95d:	74 79                	je     9d8 <printint+0x98>
    neg = 1;
 95f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 966:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 968:	31 db                	xor    %ebx,%ebx
 96a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 96d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 970:	89 c8                	mov    %ecx,%eax
 972:	31 d2                	xor    %edx,%edx
 974:	89 cf                	mov    %ecx,%edi
 976:	f7 75 c4             	divl   -0x3c(%ebp)
 979:	0f b6 92 e4 0d 00 00 	movzbl 0xde4(%edx),%edx
 980:	89 45 c0             	mov    %eax,-0x40(%ebp)
 983:	89 d8                	mov    %ebx,%eax
 985:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 988:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 98b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 98e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 991:	76 dd                	jbe    970 <printint+0x30>
  if(neg)
 993:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 996:	85 c9                	test   %ecx,%ecx
 998:	74 0c                	je     9a6 <printint+0x66>
    buf[i++] = '-';
 99a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 99f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 9a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 9a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 9a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 9ad:	eb 07                	jmp    9b6 <printint+0x76>
 9af:	90                   	nop
    putc(fd, buf[i]);
 9b0:	0f b6 13             	movzbl (%ebx),%edx
 9b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 9b6:	83 ec 04             	sub    $0x4,%esp
 9b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 9bc:	6a 01                	push   $0x1
 9be:	56                   	push   %esi
 9bf:	57                   	push   %edi
 9c0:	e8 ee fe ff ff       	call   8b3 <write>
  while(--i >= 0)
 9c5:	83 c4 10             	add    $0x10,%esp
 9c8:	39 de                	cmp    %ebx,%esi
 9ca:	75 e4                	jne    9b0 <printint+0x70>
}
 9cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9cf:	5b                   	pop    %ebx
 9d0:	5e                   	pop    %esi
 9d1:	5f                   	pop    %edi
 9d2:	5d                   	pop    %ebp
 9d3:	c3                   	ret    
 9d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 9d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 9df:	eb 87                	jmp    968 <printint+0x28>
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ef:	90                   	nop

000009f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	57                   	push   %edi
 9f4:	56                   	push   %esi
 9f5:	53                   	push   %ebx
 9f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 9f9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 9fc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 9ff:	0f b6 13             	movzbl (%ebx),%edx
 a02:	84 d2                	test   %dl,%dl
 a04:	74 6a                	je     a70 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 a06:	8d 45 10             	lea    0x10(%ebp),%eax
 a09:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a0c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 a0f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 a11:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a14:	eb 36                	jmp    a4c <printf+0x5c>
 a16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
 a20:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a23:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 a28:	83 f8 25             	cmp    $0x25,%eax
 a2b:	74 15                	je     a42 <printf+0x52>
  write(fd, &c, 1);
 a2d:	83 ec 04             	sub    $0x4,%esp
 a30:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a33:	6a 01                	push   $0x1
 a35:	57                   	push   %edi
 a36:	56                   	push   %esi
 a37:	e8 77 fe ff ff       	call   8b3 <write>
 a3c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 a3f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a42:	0f b6 13             	movzbl (%ebx),%edx
 a45:	83 c3 01             	add    $0x1,%ebx
 a48:	84 d2                	test   %dl,%dl
 a4a:	74 24                	je     a70 <printf+0x80>
    c = fmt[i] & 0xff;
 a4c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 a4f:	85 c9                	test   %ecx,%ecx
 a51:	74 cd                	je     a20 <printf+0x30>
      }
    } else if(state == '%'){
 a53:	83 f9 25             	cmp    $0x25,%ecx
 a56:	75 ea                	jne    a42 <printf+0x52>
      if(c == 'd'){
 a58:	83 f8 25             	cmp    $0x25,%eax
 a5b:	0f 84 07 01 00 00    	je     b68 <printf+0x178>
 a61:	83 e8 63             	sub    $0x63,%eax
 a64:	83 f8 15             	cmp    $0x15,%eax
 a67:	77 17                	ja     a80 <printf+0x90>
 a69:	ff 24 85 8c 0d 00 00 	jmp    *0xd8c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a73:	5b                   	pop    %ebx
 a74:	5e                   	pop    %esi
 a75:	5f                   	pop    %edi
 a76:	5d                   	pop    %ebp
 a77:	c3                   	ret    
 a78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a7f:	90                   	nop
  write(fd, &c, 1);
 a80:	83 ec 04             	sub    $0x4,%esp
 a83:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 a86:	6a 01                	push   $0x1
 a88:	57                   	push   %edi
 a89:	56                   	push   %esi
 a8a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 a8e:	e8 20 fe ff ff       	call   8b3 <write>
        putc(fd, c);
 a93:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 a97:	83 c4 0c             	add    $0xc,%esp
 a9a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a9d:	6a 01                	push   $0x1
 a9f:	57                   	push   %edi
 aa0:	56                   	push   %esi
 aa1:	e8 0d fe ff ff       	call   8b3 <write>
        putc(fd, c);
 aa6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 aa9:	31 c9                	xor    %ecx,%ecx
 aab:	eb 95                	jmp    a42 <printf+0x52>
 aad:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 ab0:	83 ec 0c             	sub    $0xc,%esp
 ab3:	b9 10 00 00 00       	mov    $0x10,%ecx
 ab8:	6a 00                	push   $0x0
 aba:	8b 45 d0             	mov    -0x30(%ebp),%eax
 abd:	8b 10                	mov    (%eax),%edx
 abf:	89 f0                	mov    %esi,%eax
 ac1:	e8 7a fe ff ff       	call   940 <printint>
        ap++;
 ac6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 aca:	83 c4 10             	add    $0x10,%esp
      state = 0;
 acd:	31 c9                	xor    %ecx,%ecx
 acf:	e9 6e ff ff ff       	jmp    a42 <printf+0x52>
 ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 ad8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 adb:	8b 10                	mov    (%eax),%edx
        ap++;
 add:	83 c0 04             	add    $0x4,%eax
 ae0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 ae3:	85 d2                	test   %edx,%edx
 ae5:	0f 84 8d 00 00 00    	je     b78 <printf+0x188>
        while(*s != 0){
 aeb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 aee:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 af0:	84 c0                	test   %al,%al
 af2:	0f 84 4a ff ff ff    	je     a42 <printf+0x52>
 af8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 afb:	89 d3                	mov    %edx,%ebx
 afd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b00:	83 ec 04             	sub    $0x4,%esp
          s++;
 b03:	83 c3 01             	add    $0x1,%ebx
 b06:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b09:	6a 01                	push   $0x1
 b0b:	57                   	push   %edi
 b0c:	56                   	push   %esi
 b0d:	e8 a1 fd ff ff       	call   8b3 <write>
        while(*s != 0){
 b12:	0f b6 03             	movzbl (%ebx),%eax
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	84 c0                	test   %al,%al
 b1a:	75 e4                	jne    b00 <printf+0x110>
      state = 0;
 b1c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 b1f:	31 c9                	xor    %ecx,%ecx
 b21:	e9 1c ff ff ff       	jmp    a42 <printf+0x52>
 b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b2d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 b30:	83 ec 0c             	sub    $0xc,%esp
 b33:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b38:	6a 01                	push   $0x1
 b3a:	e9 7b ff ff ff       	jmp    aba <printf+0xca>
 b3f:	90                   	nop
        putc(fd, *ap);
 b40:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 b43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 b46:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 b48:	6a 01                	push   $0x1
 b4a:	57                   	push   %edi
 b4b:	56                   	push   %esi
        putc(fd, *ap);
 b4c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b4f:	e8 5f fd ff ff       	call   8b3 <write>
        ap++;
 b54:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b58:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b5b:	31 c9                	xor    %ecx,%ecx
 b5d:	e9 e0 fe ff ff       	jmp    a42 <printf+0x52>
 b62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 b68:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 b6b:	83 ec 04             	sub    $0x4,%esp
 b6e:	e9 2a ff ff ff       	jmp    a9d <printf+0xad>
 b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b77:	90                   	nop
          s = "(null)";
 b78:	ba 82 0d 00 00       	mov    $0xd82,%edx
        while(*s != 0){
 b7d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b80:	b8 28 00 00 00       	mov    $0x28,%eax
 b85:	89 d3                	mov    %edx,%ebx
 b87:	e9 74 ff ff ff       	jmp    b00 <printf+0x110>
 b8c:	66 90                	xchg   %ax,%ax
 b8e:	66 90                	xchg   %ax,%ax

00000b90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b90:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b91:	a1 74 11 00 00       	mov    0x1174,%eax
{
 b96:	89 e5                	mov    %esp,%ebp
 b98:	57                   	push   %edi
 b99:	56                   	push   %esi
 b9a:	53                   	push   %ebx
 b9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 b9e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 ba8:	89 c2                	mov    %eax,%edx
 baa:	8b 00                	mov    (%eax),%eax
 bac:	39 ca                	cmp    %ecx,%edx
 bae:	73 30                	jae    be0 <free+0x50>
 bb0:	39 c1                	cmp    %eax,%ecx
 bb2:	72 04                	jb     bb8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb4:	39 c2                	cmp    %eax,%edx
 bb6:	72 f0                	jb     ba8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bb8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 bbb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 bbe:	39 f8                	cmp    %edi,%eax
 bc0:	74 30                	je     bf2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 bc2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 bc5:	8b 42 04             	mov    0x4(%edx),%eax
 bc8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 bcb:	39 f1                	cmp    %esi,%ecx
 bcd:	74 3a                	je     c09 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 bcf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 bd1:	5b                   	pop    %ebx
  freep = p;
 bd2:	89 15 74 11 00 00    	mov    %edx,0x1174
}
 bd8:	5e                   	pop    %esi
 bd9:	5f                   	pop    %edi
 bda:	5d                   	pop    %ebp
 bdb:	c3                   	ret    
 bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 be0:	39 c2                	cmp    %eax,%edx
 be2:	72 c4                	jb     ba8 <free+0x18>
 be4:	39 c1                	cmp    %eax,%ecx
 be6:	73 c0                	jae    ba8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 be8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 beb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 bee:	39 f8                	cmp    %edi,%eax
 bf0:	75 d0                	jne    bc2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 bf2:	03 70 04             	add    0x4(%eax),%esi
 bf5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bf8:	8b 02                	mov    (%edx),%eax
 bfa:	8b 00                	mov    (%eax),%eax
 bfc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 bff:	8b 42 04             	mov    0x4(%edx),%eax
 c02:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c05:	39 f1                	cmp    %esi,%ecx
 c07:	75 c6                	jne    bcf <free+0x3f>
    p->s.size += bp->s.size;
 c09:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 c0c:	89 15 74 11 00 00    	mov    %edx,0x1174
    p->s.size += bp->s.size;
 c12:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 c15:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c18:	89 0a                	mov    %ecx,(%edx)
}
 c1a:	5b                   	pop    %ebx
 c1b:	5e                   	pop    %esi
 c1c:	5f                   	pop    %edi
 c1d:	5d                   	pop    %ebp
 c1e:	c3                   	ret    
 c1f:	90                   	nop

00000c20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c20:	55                   	push   %ebp
 c21:	89 e5                	mov    %esp,%ebp
 c23:	57                   	push   %edi
 c24:	56                   	push   %esi
 c25:	53                   	push   %ebx
 c26:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c29:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c2c:	8b 3d 74 11 00 00    	mov    0x1174,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c32:	8d 70 07             	lea    0x7(%eax),%esi
 c35:	c1 ee 03             	shr    $0x3,%esi
 c38:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 c3b:	85 ff                	test   %edi,%edi
 c3d:	0f 84 9d 00 00 00    	je     ce0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c43:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 c45:	8b 4a 04             	mov    0x4(%edx),%ecx
 c48:	39 f1                	cmp    %esi,%ecx
 c4a:	73 6a                	jae    cb6 <malloc+0x96>
 c4c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 c51:	39 de                	cmp    %ebx,%esi
 c53:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 c56:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 c5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c60:	eb 17                	jmp    c79 <malloc+0x59>
 c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c6a:	8b 48 04             	mov    0x4(%eax),%ecx
 c6d:	39 f1                	cmp    %esi,%ecx
 c6f:	73 4f                	jae    cc0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c71:	8b 3d 74 11 00 00    	mov    0x1174,%edi
 c77:	89 c2                	mov    %eax,%edx
 c79:	39 d7                	cmp    %edx,%edi
 c7b:	75 eb                	jne    c68 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 c7d:	83 ec 0c             	sub    $0xc,%esp
 c80:	ff 75 e4             	push   -0x1c(%ebp)
 c83:	e8 93 fc ff ff       	call   91b <sbrk>
  if(p == (char*)-1)
 c88:	83 c4 10             	add    $0x10,%esp
 c8b:	83 f8 ff             	cmp    $0xffffffff,%eax
 c8e:	74 1c                	je     cac <malloc+0x8c>
  hp->s.size = nu;
 c90:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 c93:	83 ec 0c             	sub    $0xc,%esp
 c96:	83 c0 08             	add    $0x8,%eax
 c99:	50                   	push   %eax
 c9a:	e8 f1 fe ff ff       	call   b90 <free>
  return freep;
 c9f:	8b 15 74 11 00 00    	mov    0x1174,%edx
      if((p = morecore(nunits)) == 0)
 ca5:	83 c4 10             	add    $0x10,%esp
 ca8:	85 d2                	test   %edx,%edx
 caa:	75 bc                	jne    c68 <malloc+0x48>
        return 0;
  }
}
 cac:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 caf:	31 c0                	xor    %eax,%eax
}
 cb1:	5b                   	pop    %ebx
 cb2:	5e                   	pop    %esi
 cb3:	5f                   	pop    %edi
 cb4:	5d                   	pop    %ebp
 cb5:	c3                   	ret    
    if(p->s.size >= nunits){
 cb6:	89 d0                	mov    %edx,%eax
 cb8:	89 fa                	mov    %edi,%edx
 cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 cc0:	39 ce                	cmp    %ecx,%esi
 cc2:	74 4c                	je     d10 <malloc+0xf0>
        p->s.size -= nunits;
 cc4:	29 f1                	sub    %esi,%ecx
 cc6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 cc9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ccc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 ccf:	89 15 74 11 00 00    	mov    %edx,0x1174
}
 cd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 cd8:	83 c0 08             	add    $0x8,%eax
}
 cdb:	5b                   	pop    %ebx
 cdc:	5e                   	pop    %esi
 cdd:	5f                   	pop    %edi
 cde:	5d                   	pop    %ebp
 cdf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 ce0:	c7 05 74 11 00 00 78 	movl   $0x1178,0x1174
 ce7:	11 00 00 
    base.s.size = 0;
 cea:	bf 78 11 00 00       	mov    $0x1178,%edi
    base.s.ptr = freep = prevp = &base;
 cef:	c7 05 78 11 00 00 78 	movl   $0x1178,0x1178
 cf6:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cf9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 cfb:	c7 05 7c 11 00 00 00 	movl   $0x0,0x117c
 d02:	00 00 00 
    if(p->s.size >= nunits){
 d05:	e9 42 ff ff ff       	jmp    c4c <malloc+0x2c>
 d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 d10:	8b 08                	mov    (%eax),%ecx
 d12:	89 0a                	mov    %ecx,(%edx)
 d14:	eb b9                	jmp    ccf <malloc+0xaf>
