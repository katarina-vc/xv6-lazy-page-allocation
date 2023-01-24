
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
  33:	68 9f 0d 00 00       	push   $0xd9f
  38:	ff 34 9f             	push   (%edi,%ebx,4)
  3b:	e8 50 06 00 00       	call   690 <strcmp>
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
  5c:	68 9d 0d 00 00       	push   $0xd9d
  61:	e8 5a 03 00 00       	call   3c0 <ls_a>
  66:	83 c4 10             	add    $0x10,%esp





  exit();
  69:	e8 45 08 00 00       	call   8b3 <exit>
    ls(".");
  6e:	83 ec 0c             	sub    $0xc,%esp
  71:	68 9d 0d 00 00       	push   $0xd9d
  76:	e8 95 00 00 00       	call   110 <ls>
  7b:	83 c4 10             	add    $0x10,%esp
  7e:	eb e9                	jmp    69 <main+0x69>
    ls(".");
  80:	83 ec 0c             	sub    $0xc,%esp
  83:	68 9d 0d 00 00       	push   $0xd9d
  88:	e8 83 00 00 00       	call   110 <ls>
    exit();
  8d:	e8 21 08 00 00       	call   8b3 <exit>
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
  ac:	e8 3f 06 00 00       	call   6f0 <strlen>
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
  d5:	e8 16 06 00 00       	call   6f0 <strlen>
  da:	83 c4 10             	add    $0x10,%esp
  dd:	83 f8 0d             	cmp    $0xd,%eax
  e0:	77 20                	ja     102 <fmtname+0x62>
  memmove(buf, p, strlen(p));
  e2:	83 ec 0c             	sub    $0xc,%esp
  e5:	53                   	push   %ebx
  e6:	e8 05 06 00 00       	call   6f0 <strlen>
  eb:	83 c4 0c             	add    $0xc,%esp
  ee:	50                   	push   %eax
  ef:	53                   	push   %ebx
  return buf;
  f0:	bb 84 11 00 00       	mov    $0x1184,%ebx
  memmove(buf, p, strlen(p));
  f5:	68 84 11 00 00       	push   $0x1184
  fa:	e8 81 07 00 00       	call   880 <memmove>
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
 116:	81 ec 54 02 00 00    	sub    $0x254,%esp
 11c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 11f:	6a 00                	push   $0x0
 121:	57                   	push   %edi
 122:	e8 cc 07 00 00       	call   8f3 <open>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	85 c0                	test   %eax,%eax
 12c:	0f 88 b6 01 00 00    	js     2e8 <ls+0x1d8>
  if(fstat(fd, &st) < 0){
 132:	83 ec 08             	sub    $0x8,%esp
 135:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 13b:	89 c3                	mov    %eax,%ebx
 13d:	56                   	push   %esi
 13e:	50                   	push   %eax
 13f:	e8 c7 07 00 00       	call   90b <fstat>
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
 166:	e8 70 07 00 00       	call   8db <close>
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
 1a8:	68 60 0d 00 00       	push   $0xd60
 1ad:	6a 01                	push   $0x1
 1af:	e8 5c 08 00 00       	call   a10 <printf>
    break;
 1b4:	83 c4 20             	add    $0x20,%esp
 1b7:	eb a9                	jmp    162 <ls+0x52>
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1c0:	83 ec 0c             	sub    $0xc,%esp
 1c3:	57                   	push   %edi
 1c4:	e8 27 05 00 00       	call   6f0 <strlen>
 1c9:	83 c4 10             	add    $0x10,%esp
 1cc:	83 c0 10             	add    $0x10,%eax
 1cf:	3d 00 02 00 00       	cmp    $0x200,%eax
 1d4:	0f 87 2e 01 00 00    	ja     308 <ls+0x1f8>
    strcpy(buf, path);
 1da:	83 ec 08             	sub    $0x8,%esp
 1dd:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1e3:	57                   	push   %edi
 1e4:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1ea:	50                   	push   %eax
 1eb:	e8 70 04 00 00       	call   660 <strcpy>
    p = buf+strlen(buf);
 1f0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1f6:	89 04 24             	mov    %eax,(%esp)
 1f9:	e8 f2 04 00 00       	call   6f0 <strlen>
 1fe:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 204:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 207:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 209:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 20c:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 212:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 218:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 21b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop
 220:	83 ec 04             	sub    $0x4,%esp
 223:	6a 10                	push   $0x10
 225:	57                   	push   %edi
 226:	53                   	push   %ebx
 227:	e8 9f 06 00 00       	call   8cb <read>
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	83 f8 10             	cmp    $0x10,%eax
 232:	0f 85 2a ff ff ff    	jne    162 <ls+0x52>
      if(de.inum == 0)
 238:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 23f:	00 
 240:	74 de                	je     220 <ls+0x110>
      memmove(p, de.name, DIRSIZ);
 242:	83 ec 04             	sub    $0x4,%esp
 245:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 24b:	6a 0e                	push   $0xe
 24d:	50                   	push   %eax
 24e:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
 254:	e8 27 06 00 00       	call   880 <memmove>
      p[DIRSIZ] = 0;
 259:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 25f:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 263:	58                   	pop    %eax
 264:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 26a:	5a                   	pop    %edx
 26b:	56                   	push   %esi
 26c:	50                   	push   %eax
 26d:	e8 7e 05 00 00       	call   7f0 <stat>
 272:	83 c4 10             	add    $0x10,%esp
 275:	85 c0                	test   %eax,%eax
 277:	0f 88 23 01 00 00    	js     3a0 <ls+0x290>
      if (st.type == 1){
 27d:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 284:	66 83 f8 01          	cmp    $0x1,%ax
 288:	0f 84 ba 00 00 00    	je     348 <ls+0x238>
      else if (st.type==2){
 28e:	66 83 f8 02          	cmp    $0x2,%ax
 292:	75 8c                	jne    220 <ls+0x110>
      	printf(1, "%s\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 294:	83 ec 0c             	sub    $0xc,%esp
 297:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 29d:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 2a3:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 2a9:	50                   	push   %eax
 2aa:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 2b0:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 2b6:	e8 e5 fd ff ff       	call   a0 <fmtname>
 2bb:	5a                   	pop    %edx
 2bc:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 2c2:	59                   	pop    %ecx
 2c3:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 2c9:	51                   	push   %ecx
 2ca:	52                   	push   %edx
 2cb:	6a 02                	push   $0x2
 2cd:	50                   	push   %eax
 2ce:	68 8f 0d 00 00       	push   $0xd8f
 2d3:	6a 01                	push   $0x1
 2d5:	e8 36 07 00 00       	call   a10 <printf>
 2da:	83 c4 20             	add    $0x20,%esp
 2dd:	e9 3e ff ff ff       	jmp    220 <ls+0x110>
 2e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 2e8:	83 ec 04             	sub    $0x4,%esp
 2eb:	57                   	push   %edi
 2ec:	68 38 0d 00 00       	push   $0xd38
 2f1:	6a 02                	push   $0x2
 2f3:	e8 18 07 00 00       	call   a10 <printf>
    return;
 2f8:	83 c4 10             	add    $0x10,%esp
}
 2fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fe:	5b                   	pop    %ebx
 2ff:	5e                   	pop    %esi
 300:	5f                   	pop    %edi
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 307:	90                   	nop
      printf(1, "ls: path too long\n");
 308:	83 ec 08             	sub    $0x8,%esp
 30b:	68 6d 0d 00 00       	push   $0xd6d
 310:	6a 01                	push   $0x1
 312:	e8 f9 06 00 00       	call   a10 <printf>
      break;
 317:	83 c4 10             	add    $0x10,%esp
 31a:	e9 43 fe ff ff       	jmp    162 <ls+0x52>
 31f:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	57                   	push   %edi
 324:	68 4c 0d 00 00       	push   $0xd4c
 329:	6a 02                	push   $0x2
 32b:	e8 e0 06 00 00       	call   a10 <printf>
    close(fd);
 330:	89 1c 24             	mov    %ebx,(%esp)
 333:	e8 a3 05 00 00       	call   8db <close>
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
 34b:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 351:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 357:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 35d:	50                   	push   %eax
 35e:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 364:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 36a:	e8 31 fd ff ff       	call   a0 <fmtname>
 36f:	5a                   	pop    %edx
 370:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 376:	59                   	pop    %ecx
 377:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 37d:	51                   	push   %ecx
 37e:	52                   	push   %edx
 37f:	6a 01                	push   $0x1
 381:	50                   	push   %eax
 382:	68 80 0d 00 00       	push   $0xd80
 387:	6a 01                	push   $0x1
 389:	e8 82 06 00 00       	call   a10 <printf>
 38e:	83 c4 20             	add    $0x20,%esp
 391:	e9 8a fe ff ff       	jmp    220 <ls+0x110>
 396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39d:	8d 76 00             	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 3a0:	83 ec 04             	sub    $0x4,%esp
 3a3:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 3a9:	50                   	push   %eax
 3aa:	68 4c 0d 00 00       	push   $0xd4c
 3af:	6a 01                	push   $0x1
 3b1:	e8 5a 06 00 00       	call   a10 <printf>
        continue;
 3b6:	83 c4 10             	add    $0x10,%esp
 3b9:	e9 62 fe ff ff       	jmp    220 <ls+0x110>
 3be:	66 90                	xchg   %ax,%ax

000003c0 <ls_a>:
ls_a(char* path){
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	81 ec 54 02 00 00    	sub    $0x254,%esp
 3cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if((fd = open(path, 0)) < 0){
 3cf:	6a 00                	push   $0x0
 3d1:	57                   	push   %edi
 3d2:	e8 1c 05 00 00       	call   8f3 <open>
 3d7:	83 c4 10             	add    $0x10,%esp
 3da:	85 c0                	test   %eax,%eax
 3dc:	0f 88 b6 01 00 00    	js     598 <ls_a+0x1d8>
  if(fstat(fd, &st) < 0){
 3e2:	83 ec 08             	sub    $0x8,%esp
 3e5:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 3eb:	89 c3                	mov    %eax,%ebx
 3ed:	56                   	push   %esi
 3ee:	50                   	push   %eax
 3ef:	e8 17 05 00 00       	call   90b <fstat>
 3f4:	83 c4 10             	add    $0x10,%esp
 3f7:	85 c0                	test   %eax,%eax
 3f9:	0f 88 d1 01 00 00    	js     5d0 <ls_a+0x210>
  switch(st.type){
 3ff:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 406:	66 83 f8 01          	cmp    $0x1,%ax
 40a:	74 64                	je     470 <ls_a+0xb0>
 40c:	66 83 f8 02          	cmp    $0x2,%ax
 410:	74 1e                	je     430 <ls_a+0x70>
   close(fd);
 412:	83 ec 0c             	sub    $0xc,%esp
 415:	53                   	push   %ebx
 416:	e8 c0 04 00 00       	call   8db <close>
 41b:	83 c4 10             	add    $0x10,%esp
}
 41e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 421:	5b                   	pop    %ebx
 422:	5e                   	pop    %esi
 423:	5f                   	pop    %edi
 424:	5d                   	pop    %ebp
 425:	c3                   	ret    
 426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 430:	83 ec 0c             	sub    $0xc,%esp
 433:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 439:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 43f:	57                   	push   %edi
 440:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 446:	e8 55 fc ff ff       	call   a0 <fmtname>
 44b:	5a                   	pop    %edx
 44c:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 452:	59                   	pop    %ecx
 453:	52                   	push   %edx
 454:	56                   	push   %esi
 455:	6a 02                	push   $0x2
 457:	50                   	push   %eax
 458:	68 60 0d 00 00       	push   $0xd60
 45d:	6a 01                	push   $0x1
 45f:	e8 ac 05 00 00       	call   a10 <printf>
    break;
 464:	83 c4 20             	add    $0x20,%esp
 467:	eb a9                	jmp    412 <ls_a+0x52>
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 470:	83 ec 0c             	sub    $0xc,%esp
 473:	57                   	push   %edi
 474:	e8 77 02 00 00       	call   6f0 <strlen>
 479:	83 c4 10             	add    $0x10,%esp
 47c:	83 c0 10             	add    $0x10,%eax
 47f:	3d 00 02 00 00       	cmp    $0x200,%eax
 484:	0f 87 2e 01 00 00    	ja     5b8 <ls_a+0x1f8>
    strcpy(buf, path);
 48a:	83 ec 08             	sub    $0x8,%esp
 48d:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 493:	57                   	push   %edi
 494:	50                   	push   %eax
 495:	e8 c6 01 00 00       	call   660 <strcpy>
    p = buf+strlen(buf);
 49a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 4a0:	89 04 24             	mov    %eax,(%esp)
 4a3:	e8 48 02 00 00       	call   6f0 <strlen>
 4a8:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 4ae:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 4b1:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 4b3:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 4b6:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 4bc:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 4c2:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
 4c8:	83 ec 04             	sub    $0x4,%esp
 4cb:	8d 85 c4 fd ff ff    	lea    -0x23c(%ebp),%eax
 4d1:	6a 10                	push   $0x10
 4d3:	50                   	push   %eax
 4d4:	53                   	push   %ebx
 4d5:	e8 f1 03 00 00       	call   8cb <read>
 4da:	83 c4 10             	add    $0x10,%esp
 4dd:	83 f8 10             	cmp    $0x10,%eax
 4e0:	0f 85 2c ff ff ff    	jne    412 <ls_a+0x52>
      if(de.inum == 0)
 4e6:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 4ed:	00 
 4ee:	74 d8                	je     4c8 <ls_a+0x108>
      memmove(p, de.name, DIRSIZ);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 4f9:	6a 0e                	push   $0xe
 4fb:	50                   	push   %eax
 4fc:	ff b5 b0 fd ff ff    	push   -0x250(%ebp)
 502:	e8 79 03 00 00       	call   880 <memmove>
      p[DIRSIZ] = 0;
 507:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 50d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 511:	5f                   	pop    %edi
 512:	58                   	pop    %eax
 513:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 519:	56                   	push   %esi
 51a:	50                   	push   %eax
 51b:	e8 d0 02 00 00       	call   7f0 <stat>
 520:	83 c4 10             	add    $0x10,%esp
 523:	85 c0                	test   %eax,%eax
 525:	0f 88 15 01 00 00    	js     640 <ls_a+0x280>
      if (st.type == 1){
 52b:	0f bf bd d4 fd ff ff 	movswl -0x22c(%ebp),%edi
 532:	66 83 ff 01          	cmp    $0x1,%di
 536:	0f 84 bc 00 00 00    	je     5f8 <ls_a+0x238>
      else if (st.type==2 || st.type==3){
 53c:	8d 47 fe             	lea    -0x2(%edi),%eax
 53f:	66 83 f8 01          	cmp    $0x1,%ax
 543:	77 83                	ja     4c8 <ls_a+0x108>
        printf(1, "%s\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 545:	83 ec 0c             	sub    $0xc,%esp
 548:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 54e:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 554:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 55a:	50                   	push   %eax
 55b:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 561:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 567:	e8 34 fb ff ff       	call   a0 <fmtname>
 56c:	5a                   	pop    %edx
 56d:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 573:	59                   	pop    %ecx
 574:	8b 8d a8 fd ff ff    	mov    -0x258(%ebp),%ecx
 57a:	51                   	push   %ecx
 57b:	52                   	push   %edx
 57c:	57                   	push   %edi
 57d:	50                   	push   %eax
 57e:	68 8f 0d 00 00       	push   $0xd8f
 583:	6a 01                	push   $0x1
 585:	e8 86 04 00 00       	call   a10 <printf>
 58a:	83 c4 20             	add    $0x20,%esp
 58d:	e9 36 ff ff ff       	jmp    4c8 <ls_a+0x108>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(2, "ls: cannot open %s\n", path);
 598:	83 ec 04             	sub    $0x4,%esp
 59b:	57                   	push   %edi
 59c:	68 38 0d 00 00       	push   $0xd38
 5a1:	6a 02                	push   $0x2
 5a3:	e8 68 04 00 00       	call   a10 <printf>
    return;
 5a8:	83 c4 10             	add    $0x10,%esp
}
 5ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ae:	5b                   	pop    %ebx
 5af:	5e                   	pop    %esi
 5b0:	5f                   	pop    %edi
 5b1:	5d                   	pop    %ebp
 5b2:	c3                   	ret    
 5b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b7:	90                   	nop
      printf(1, "ls: path too long\n");
 5b8:	83 ec 08             	sub    $0x8,%esp
 5bb:	68 6d 0d 00 00       	push   $0xd6d
 5c0:	6a 01                	push   $0x1
 5c2:	e8 49 04 00 00       	call   a10 <printf>
      break;
 5c7:	83 c4 10             	add    $0x10,%esp
 5ca:	e9 43 fe ff ff       	jmp    412 <ls_a+0x52>
 5cf:	90                   	nop
    printf(2, "ls: cannot stat %s\n", path);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	57                   	push   %edi
 5d4:	68 4c 0d 00 00       	push   $0xd4c
 5d9:	6a 02                	push   $0x2
 5db:	e8 30 04 00 00       	call   a10 <printf>
    close(fd);
 5e0:	89 1c 24             	mov    %ebx,(%esp)
 5e3:	e8 f3 02 00 00       	call   8db <close>
    return;
 5e8:	83 c4 10             	add    $0x10,%esp
}
 5eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ee:	5b                   	pop    %ebx
 5ef:	5e                   	pop    %esi
 5f0:	5f                   	pop    %edi
 5f1:	5d                   	pop    %ebp
 5f2:	c3                   	ret    
 5f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f7:	90                   	nop
        printf(1, "%s/\t %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 5f8:	83 ec 0c             	sub    $0xc,%esp
 5fb:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 601:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 607:	8b bd dc fd ff ff    	mov    -0x224(%ebp),%edi
 60d:	50                   	push   %eax
 60e:	89 95 ac fd ff ff    	mov    %edx,-0x254(%ebp)
 614:	e8 87 fa ff ff       	call   a0 <fmtname>
 619:	5a                   	pop    %edx
 61a:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 620:	59                   	pop    %ecx
 621:	52                   	push   %edx
 622:	57                   	push   %edi
 623:	6a 01                	push   $0x1
 625:	50                   	push   %eax
 626:	68 80 0d 00 00       	push   $0xd80
 62b:	6a 01                	push   $0x1
 62d:	e8 de 03 00 00       	call   a10 <printf>
 632:	83 c4 20             	add    $0x20,%esp
 635:	e9 8e fe ff ff       	jmp    4c8 <ls_a+0x108>
 63a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 640:	83 ec 04             	sub    $0x4,%esp
 643:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 649:	50                   	push   %eax
 64a:	68 4c 0d 00 00       	push   $0xd4c
 64f:	6a 01                	push   $0x1
 651:	e8 ba 03 00 00       	call   a10 <printf>
        continue;
 656:	83 c4 10             	add    $0x10,%esp
 659:	e9 6a fe ff ff       	jmp    4c8 <ls_a+0x108>
 65e:	66 90                	xchg   %ax,%ax

00000660 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 660:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 661:	31 c0                	xor    %eax,%eax
{
 663:	89 e5                	mov    %esp,%ebp
 665:	53                   	push   %ebx
 666:	8b 4d 08             	mov    0x8(%ebp),%ecx
 669:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 670:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 674:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 677:	83 c0 01             	add    $0x1,%eax
 67a:	84 d2                	test   %dl,%dl
 67c:	75 f2                	jne    670 <strcpy+0x10>
    ;
  return os;
}
 67e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 681:	89 c8                	mov    %ecx,%eax
 683:	c9                   	leave  
 684:	c3                   	ret    
 685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	53                   	push   %ebx
 694:	8b 55 08             	mov    0x8(%ebp),%edx
 697:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 69a:	0f b6 02             	movzbl (%edx),%eax
 69d:	84 c0                	test   %al,%al
 69f:	75 17                	jne    6b8 <strcmp+0x28>
 6a1:	eb 3a                	jmp    6dd <strcmp+0x4d>
 6a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a7:	90                   	nop
 6a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 6ac:	83 c2 01             	add    $0x1,%edx
 6af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 6b2:	84 c0                	test   %al,%al
 6b4:	74 1a                	je     6d0 <strcmp+0x40>
    p++, q++;
 6b6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 6b8:	0f b6 19             	movzbl (%ecx),%ebx
 6bb:	38 c3                	cmp    %al,%bl
 6bd:	74 e9                	je     6a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 6bf:	29 d8                	sub    %ebx,%eax
}
 6c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6c4:	c9                   	leave  
 6c5:	c3                   	ret    
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 6d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 6d4:	31 c0                	xor    %eax,%eax
 6d6:	29 d8                	sub    %ebx,%eax
}
 6d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6db:	c9                   	leave  
 6dc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 6dd:	0f b6 19             	movzbl (%ecx),%ebx
 6e0:	31 c0                	xor    %eax,%eax
 6e2:	eb db                	jmp    6bf <strcmp+0x2f>
 6e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop

000006f0 <strlen>:

uint
strlen(const char *s)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 6f6:	80 3a 00             	cmpb   $0x0,(%edx)
 6f9:	74 15                	je     710 <strlen+0x20>
 6fb:	31 c0                	xor    %eax,%eax
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
 700:	83 c0 01             	add    $0x1,%eax
 703:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 707:	89 c1                	mov    %eax,%ecx
 709:	75 f5                	jne    700 <strlen+0x10>
    ;
  return n;
}
 70b:	89 c8                	mov    %ecx,%eax
 70d:	5d                   	pop    %ebp
 70e:	c3                   	ret    
 70f:	90                   	nop
  for(n = 0; s[n]; n++)
 710:	31 c9                	xor    %ecx,%ecx
}
 712:	5d                   	pop    %ebp
 713:	89 c8                	mov    %ecx,%eax
 715:	c3                   	ret    
 716:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71d:	8d 76 00             	lea    0x0(%esi),%esi

00000720 <memset>:

void*
memset(void *dst, int c, uint n)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 727:	8b 4d 10             	mov    0x10(%ebp),%ecx
 72a:	8b 45 0c             	mov    0xc(%ebp),%eax
 72d:	89 d7                	mov    %edx,%edi
 72f:	fc                   	cld    
 730:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 732:	8b 7d fc             	mov    -0x4(%ebp),%edi
 735:	89 d0                	mov    %edx,%eax
 737:	c9                   	leave  
 738:	c3                   	ret    
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000740 <strchr>:

char*
strchr(const char *s, char c)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	8b 45 08             	mov    0x8(%ebp),%eax
 746:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 74a:	0f b6 10             	movzbl (%eax),%edx
 74d:	84 d2                	test   %dl,%dl
 74f:	75 12                	jne    763 <strchr+0x23>
 751:	eb 1d                	jmp    770 <strchr+0x30>
 753:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 757:	90                   	nop
 758:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 75c:	83 c0 01             	add    $0x1,%eax
 75f:	84 d2                	test   %dl,%dl
 761:	74 0d                	je     770 <strchr+0x30>
    if(*s == c)
 763:	38 d1                	cmp    %dl,%cl
 765:	75 f1                	jne    758 <strchr+0x18>
      return (char*)s;
  return 0;
}
 767:	5d                   	pop    %ebp
 768:	c3                   	ret    
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 770:	31 c0                	xor    %eax,%eax
}
 772:	5d                   	pop    %ebp
 773:	c3                   	ret    
 774:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop

00000780 <gets>:

char*
gets(char *buf, int max)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 785:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 788:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 789:	31 db                	xor    %ebx,%ebx
{
 78b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 78e:	eb 27                	jmp    7b7 <gets+0x37>
    cc = read(0, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	6a 01                	push   $0x1
 795:	57                   	push   %edi
 796:	6a 00                	push   $0x0
 798:	e8 2e 01 00 00       	call   8cb <read>
    if(cc < 1)
 79d:	83 c4 10             	add    $0x10,%esp
 7a0:	85 c0                	test   %eax,%eax
 7a2:	7e 1d                	jle    7c1 <gets+0x41>
      break;
    buf[i++] = c;
 7a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7a8:	8b 55 08             	mov    0x8(%ebp),%edx
 7ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 7af:	3c 0a                	cmp    $0xa,%al
 7b1:	74 1d                	je     7d0 <gets+0x50>
 7b3:	3c 0d                	cmp    $0xd,%al
 7b5:	74 19                	je     7d0 <gets+0x50>
  for(i=0; i+1 < max; ){
 7b7:	89 de                	mov    %ebx,%esi
 7b9:	83 c3 01             	add    $0x1,%ebx
 7bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 7bf:	7c cf                	jl     790 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 7c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7cb:	5b                   	pop    %ebx
 7cc:	5e                   	pop    %esi
 7cd:	5f                   	pop    %edi
 7ce:	5d                   	pop    %ebp
 7cf:	c3                   	ret    
  buf[i] = '\0';
 7d0:	8b 45 08             	mov    0x8(%ebp),%eax
 7d3:	89 de                	mov    %ebx,%esi
 7d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 7d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7dc:	5b                   	pop    %ebx
 7dd:	5e                   	pop    %esi
 7de:	5f                   	pop    %edi
 7df:	5d                   	pop    %ebp
 7e0:	c3                   	ret    
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ef:	90                   	nop

000007f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	56                   	push   %esi
 7f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 7f5:	83 ec 08             	sub    $0x8,%esp
 7f8:	6a 00                	push   $0x0
 7fa:	ff 75 08             	push   0x8(%ebp)
 7fd:	e8 f1 00 00 00       	call   8f3 <open>
  if(fd < 0)
 802:	83 c4 10             	add    $0x10,%esp
 805:	85 c0                	test   %eax,%eax
 807:	78 27                	js     830 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 809:	83 ec 08             	sub    $0x8,%esp
 80c:	ff 75 0c             	push   0xc(%ebp)
 80f:	89 c3                	mov    %eax,%ebx
 811:	50                   	push   %eax
 812:	e8 f4 00 00 00       	call   90b <fstat>
  close(fd);
 817:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 81a:	89 c6                	mov    %eax,%esi
  close(fd);
 81c:	e8 ba 00 00 00       	call   8db <close>
  return r;
 821:	83 c4 10             	add    $0x10,%esp
}
 824:	8d 65 f8             	lea    -0x8(%ebp),%esp
 827:	89 f0                	mov    %esi,%eax
 829:	5b                   	pop    %ebx
 82a:	5e                   	pop    %esi
 82b:	5d                   	pop    %ebp
 82c:	c3                   	ret    
 82d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 830:	be ff ff ff ff       	mov    $0xffffffff,%esi
 835:	eb ed                	jmp    824 <stat+0x34>
 837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83e:	66 90                	xchg   %ax,%ax

00000840 <atoi>:

int
atoi(const char *s)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	53                   	push   %ebx
 844:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 847:	0f be 02             	movsbl (%edx),%eax
 84a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 84d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 850:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 855:	77 1e                	ja     875 <atoi+0x35>
 857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 860:	83 c2 01             	add    $0x1,%edx
 863:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 866:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 86a:	0f be 02             	movsbl (%edx),%eax
 86d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 870:	80 fb 09             	cmp    $0x9,%bl
 873:	76 eb                	jbe    860 <atoi+0x20>
  return n;
}
 875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 878:	89 c8                	mov    %ecx,%eax
 87a:	c9                   	leave  
 87b:	c3                   	ret    
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000880 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	8b 45 10             	mov    0x10(%ebp),%eax
 887:	8b 55 08             	mov    0x8(%ebp),%edx
 88a:	56                   	push   %esi
 88b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 88e:	85 c0                	test   %eax,%eax
 890:	7e 13                	jle    8a5 <memmove+0x25>
 892:	01 d0                	add    %edx,%eax
  dst = vdst;
 894:	89 d7                	mov    %edx,%edi
 896:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 8a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 8a1:	39 f8                	cmp    %edi,%eax
 8a3:	75 fb                	jne    8a0 <memmove+0x20>
  return vdst;
}
 8a5:	5e                   	pop    %esi
 8a6:	89 d0                	mov    %edx,%eax
 8a8:	5f                   	pop    %edi
 8a9:	5d                   	pop    %ebp
 8aa:	c3                   	ret    

000008ab <fork>:
 8ab:	b8 01 00 00 00       	mov    $0x1,%eax
 8b0:	cd 40                	int    $0x40
 8b2:	c3                   	ret    

000008b3 <exit>:
 8b3:	b8 02 00 00 00       	mov    $0x2,%eax
 8b8:	cd 40                	int    $0x40
 8ba:	c3                   	ret    

000008bb <wait>:
 8bb:	b8 03 00 00 00       	mov    $0x3,%eax
 8c0:	cd 40                	int    $0x40
 8c2:	c3                   	ret    

000008c3 <pipe>:
 8c3:	b8 04 00 00 00       	mov    $0x4,%eax
 8c8:	cd 40                	int    $0x40
 8ca:	c3                   	ret    

000008cb <read>:
 8cb:	b8 05 00 00 00       	mov    $0x5,%eax
 8d0:	cd 40                	int    $0x40
 8d2:	c3                   	ret    

000008d3 <write>:
 8d3:	b8 10 00 00 00       	mov    $0x10,%eax
 8d8:	cd 40                	int    $0x40
 8da:	c3                   	ret    

000008db <close>:
 8db:	b8 15 00 00 00       	mov    $0x15,%eax
 8e0:	cd 40                	int    $0x40
 8e2:	c3                   	ret    

000008e3 <kill>:
 8e3:	b8 06 00 00 00       	mov    $0x6,%eax
 8e8:	cd 40                	int    $0x40
 8ea:	c3                   	ret    

000008eb <exec>:
 8eb:	b8 07 00 00 00       	mov    $0x7,%eax
 8f0:	cd 40                	int    $0x40
 8f2:	c3                   	ret    

000008f3 <open>:
 8f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 8f8:	cd 40                	int    $0x40
 8fa:	c3                   	ret    

000008fb <mknod>:
 8fb:	b8 11 00 00 00       	mov    $0x11,%eax
 900:	cd 40                	int    $0x40
 902:	c3                   	ret    

00000903 <unlink>:
 903:	b8 12 00 00 00       	mov    $0x12,%eax
 908:	cd 40                	int    $0x40
 90a:	c3                   	ret    

0000090b <fstat>:
 90b:	b8 08 00 00 00       	mov    $0x8,%eax
 910:	cd 40                	int    $0x40
 912:	c3                   	ret    

00000913 <link>:
 913:	b8 13 00 00 00       	mov    $0x13,%eax
 918:	cd 40                	int    $0x40
 91a:	c3                   	ret    

0000091b <mkdir>:
 91b:	b8 14 00 00 00       	mov    $0x14,%eax
 920:	cd 40                	int    $0x40
 922:	c3                   	ret    

00000923 <chdir>:
 923:	b8 09 00 00 00       	mov    $0x9,%eax
 928:	cd 40                	int    $0x40
 92a:	c3                   	ret    

0000092b <dup>:
 92b:	b8 0a 00 00 00       	mov    $0xa,%eax
 930:	cd 40                	int    $0x40
 932:	c3                   	ret    

00000933 <getpid>:
 933:	b8 0b 00 00 00       	mov    $0xb,%eax
 938:	cd 40                	int    $0x40
 93a:	c3                   	ret    

0000093b <sbrk>:
 93b:	b8 0c 00 00 00       	mov    $0xc,%eax
 940:	cd 40                	int    $0x40
 942:	c3                   	ret    

00000943 <sleep>:
 943:	b8 0d 00 00 00       	mov    $0xd,%eax
 948:	cd 40                	int    $0x40
 94a:	c3                   	ret    

0000094b <uptime>:
 94b:	b8 0e 00 00 00       	mov    $0xe,%eax
 950:	cd 40                	int    $0x40
 952:	c3                   	ret    
 953:	66 90                	xchg   %ax,%ax
 955:	66 90                	xchg   %ax,%ax
 957:	66 90                	xchg   %ax,%ax
 959:	66 90                	xchg   %ax,%ax
 95b:	66 90                	xchg   %ax,%ax
 95d:	66 90                	xchg   %ax,%ax
 95f:	90                   	nop

00000960 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	57                   	push   %edi
 964:	56                   	push   %esi
 965:	53                   	push   %ebx
 966:	83 ec 3c             	sub    $0x3c,%esp
 969:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 96c:	89 d1                	mov    %edx,%ecx
{
 96e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 971:	85 d2                	test   %edx,%edx
 973:	0f 89 7f 00 00 00    	jns    9f8 <printint+0x98>
 979:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 97d:	74 79                	je     9f8 <printint+0x98>
    neg = 1;
 97f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 986:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 988:	31 db                	xor    %ebx,%ebx
 98a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 990:	89 c8                	mov    %ecx,%eax
 992:	31 d2                	xor    %edx,%edx
 994:	89 cf                	mov    %ecx,%edi
 996:	f7 75 c4             	divl   -0x3c(%ebp)
 999:	0f b6 92 04 0e 00 00 	movzbl 0xe04(%edx),%edx
 9a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 9a3:	89 d8                	mov    %ebx,%eax
 9a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 9a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 9ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 9ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 9b1:	76 dd                	jbe    990 <printint+0x30>
  if(neg)
 9b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 9b6:	85 c9                	test   %ecx,%ecx
 9b8:	74 0c                	je     9c6 <printint+0x66>
    buf[i++] = '-';
 9ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 9bf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 9c1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 9c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 9c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 9cd:	eb 07                	jmp    9d6 <printint+0x76>
 9cf:	90                   	nop
    putc(fd, buf[i]);
 9d0:	0f b6 13             	movzbl (%ebx),%edx
 9d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 9d6:	83 ec 04             	sub    $0x4,%esp
 9d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 9dc:	6a 01                	push   $0x1
 9de:	56                   	push   %esi
 9df:	57                   	push   %edi
 9e0:	e8 ee fe ff ff       	call   8d3 <write>
  while(--i >= 0)
 9e5:	83 c4 10             	add    $0x10,%esp
 9e8:	39 de                	cmp    %ebx,%esi
 9ea:	75 e4                	jne    9d0 <printint+0x70>
}
 9ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ef:	5b                   	pop    %ebx
 9f0:	5e                   	pop    %esi
 9f1:	5f                   	pop    %edi
 9f2:	5d                   	pop    %ebp
 9f3:	c3                   	ret    
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 9f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 9ff:	eb 87                	jmp    988 <printint+0x28>
 a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0f:	90                   	nop

00000a10 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 a1c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 a1f:	0f b6 13             	movzbl (%ebx),%edx
 a22:	84 d2                	test   %dl,%dl
 a24:	74 6a                	je     a90 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 a26:	8d 45 10             	lea    0x10(%ebp),%eax
 a29:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 a2c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 a2f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 a31:	89 45 d0             	mov    %eax,-0x30(%ebp)
 a34:	eb 36                	jmp    a6c <printf+0x5c>
 a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a3d:	8d 76 00             	lea    0x0(%esi),%esi
 a40:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 a43:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 a48:	83 f8 25             	cmp    $0x25,%eax
 a4b:	74 15                	je     a62 <printf+0x52>
  write(fd, &c, 1);
 a4d:	83 ec 04             	sub    $0x4,%esp
 a50:	88 55 e7             	mov    %dl,-0x19(%ebp)
 a53:	6a 01                	push   $0x1
 a55:	57                   	push   %edi
 a56:	56                   	push   %esi
 a57:	e8 77 fe ff ff       	call   8d3 <write>
 a5c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 a5f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 a62:	0f b6 13             	movzbl (%ebx),%edx
 a65:	83 c3 01             	add    $0x1,%ebx
 a68:	84 d2                	test   %dl,%dl
 a6a:	74 24                	je     a90 <printf+0x80>
    c = fmt[i] & 0xff;
 a6c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 a6f:	85 c9                	test   %ecx,%ecx
 a71:	74 cd                	je     a40 <printf+0x30>
      }
    } else if(state == '%'){
 a73:	83 f9 25             	cmp    $0x25,%ecx
 a76:	75 ea                	jne    a62 <printf+0x52>
      if(c == 'd'){
 a78:	83 f8 25             	cmp    $0x25,%eax
 a7b:	0f 84 07 01 00 00    	je     b88 <printf+0x178>
 a81:	83 e8 63             	sub    $0x63,%eax
 a84:	83 f8 15             	cmp    $0x15,%eax
 a87:	77 17                	ja     aa0 <printf+0x90>
 a89:	ff 24 85 ac 0d 00 00 	jmp    *0xdac(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a90:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a93:	5b                   	pop    %ebx
 a94:	5e                   	pop    %esi
 a95:	5f                   	pop    %edi
 a96:	5d                   	pop    %ebp
 a97:	c3                   	ret    
 a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a9f:	90                   	nop
  write(fd, &c, 1);
 aa0:	83 ec 04             	sub    $0x4,%esp
 aa3:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 aa6:	6a 01                	push   $0x1
 aa8:	57                   	push   %edi
 aa9:	56                   	push   %esi
 aaa:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 aae:	e8 20 fe ff ff       	call   8d3 <write>
        putc(fd, c);
 ab3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 ab7:	83 c4 0c             	add    $0xc,%esp
 aba:	88 55 e7             	mov    %dl,-0x19(%ebp)
 abd:	6a 01                	push   $0x1
 abf:	57                   	push   %edi
 ac0:	56                   	push   %esi
 ac1:	e8 0d fe ff ff       	call   8d3 <write>
        putc(fd, c);
 ac6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 ac9:	31 c9                	xor    %ecx,%ecx
 acb:	eb 95                	jmp    a62 <printf+0x52>
 acd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 ad0:	83 ec 0c             	sub    $0xc,%esp
 ad3:	b9 10 00 00 00       	mov    $0x10,%ecx
 ad8:	6a 00                	push   $0x0
 ada:	8b 45 d0             	mov    -0x30(%ebp),%eax
 add:	8b 10                	mov    (%eax),%edx
 adf:	89 f0                	mov    %esi,%eax
 ae1:	e8 7a fe ff ff       	call   960 <printint>
        ap++;
 ae6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 aea:	83 c4 10             	add    $0x10,%esp
      state = 0;
 aed:	31 c9                	xor    %ecx,%ecx
 aef:	e9 6e ff ff ff       	jmp    a62 <printf+0x52>
 af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 af8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 afb:	8b 10                	mov    (%eax),%edx
        ap++;
 afd:	83 c0 04             	add    $0x4,%eax
 b00:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 b03:	85 d2                	test   %edx,%edx
 b05:	0f 84 8d 00 00 00    	je     b98 <printf+0x188>
        while(*s != 0){
 b0b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 b0e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 b10:	84 c0                	test   %al,%al
 b12:	0f 84 4a ff ff ff    	je     a62 <printf+0x52>
 b18:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 b1b:	89 d3                	mov    %edx,%ebx
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b20:	83 ec 04             	sub    $0x4,%esp
          s++;
 b23:	83 c3 01             	add    $0x1,%ebx
 b26:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b29:	6a 01                	push   $0x1
 b2b:	57                   	push   %edi
 b2c:	56                   	push   %esi
 b2d:	e8 a1 fd ff ff       	call   8d3 <write>
        while(*s != 0){
 b32:	0f b6 03             	movzbl (%ebx),%eax
 b35:	83 c4 10             	add    $0x10,%esp
 b38:	84 c0                	test   %al,%al
 b3a:	75 e4                	jne    b20 <printf+0x110>
      state = 0;
 b3c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 b3f:	31 c9                	xor    %ecx,%ecx
 b41:	e9 1c ff ff ff       	jmp    a62 <printf+0x52>
 b46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b4d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 b50:	83 ec 0c             	sub    $0xc,%esp
 b53:	b9 0a 00 00 00       	mov    $0xa,%ecx
 b58:	6a 01                	push   $0x1
 b5a:	e9 7b ff ff ff       	jmp    ada <printf+0xca>
 b5f:	90                   	nop
        putc(fd, *ap);
 b60:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 b63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 b66:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 b68:	6a 01                	push   $0x1
 b6a:	57                   	push   %edi
 b6b:	56                   	push   %esi
        putc(fd, *ap);
 b6c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 b6f:	e8 5f fd ff ff       	call   8d3 <write>
        ap++;
 b74:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 b78:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b7b:	31 c9                	xor    %ecx,%ecx
 b7d:	e9 e0 fe ff ff       	jmp    a62 <printf+0x52>
 b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 b88:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 b8b:	83 ec 04             	sub    $0x4,%esp
 b8e:	e9 2a ff ff ff       	jmp    abd <printf+0xad>
 b93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b97:	90                   	nop
          s = "(null)";
 b98:	ba a2 0d 00 00       	mov    $0xda2,%edx
        while(*s != 0){
 b9d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 ba0:	b8 28 00 00 00       	mov    $0x28,%eax
 ba5:	89 d3                	mov    %edx,%ebx
 ba7:	e9 74 ff ff ff       	jmp    b20 <printf+0x110>
 bac:	66 90                	xchg   %ax,%ax
 bae:	66 90                	xchg   %ax,%ax

00000bb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 bb0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb1:	a1 94 11 00 00       	mov    0x1194,%eax
{
 bb6:	89 e5                	mov    %esp,%ebp
 bb8:	57                   	push   %edi
 bb9:	56                   	push   %esi
 bba:	53                   	push   %ebx
 bbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 bbe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bc8:	89 c2                	mov    %eax,%edx
 bca:	8b 00                	mov    (%eax),%eax
 bcc:	39 ca                	cmp    %ecx,%edx
 bce:	73 30                	jae    c00 <free+0x50>
 bd0:	39 c1                	cmp    %eax,%ecx
 bd2:	72 04                	jb     bd8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bd4:	39 c2                	cmp    %eax,%edx
 bd6:	72 f0                	jb     bc8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 bd8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 bdb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 bde:	39 f8                	cmp    %edi,%eax
 be0:	74 30                	je     c12 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 be2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 be5:	8b 42 04             	mov    0x4(%edx),%eax
 be8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 beb:	39 f1                	cmp    %esi,%ecx
 bed:	74 3a                	je     c29 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 bef:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 bf1:	5b                   	pop    %ebx
  freep = p;
 bf2:	89 15 94 11 00 00    	mov    %edx,0x1194
}
 bf8:	5e                   	pop    %esi
 bf9:	5f                   	pop    %edi
 bfa:	5d                   	pop    %ebp
 bfb:	c3                   	ret    
 bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c00:	39 c2                	cmp    %eax,%edx
 c02:	72 c4                	jb     bc8 <free+0x18>
 c04:	39 c1                	cmp    %eax,%ecx
 c06:	73 c0                	jae    bc8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 c08:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c0b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c0e:	39 f8                	cmp    %edi,%eax
 c10:	75 d0                	jne    be2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 c12:	03 70 04             	add    0x4(%eax),%esi
 c15:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c18:	8b 02                	mov    (%edx),%eax
 c1a:	8b 00                	mov    (%eax),%eax
 c1c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 c1f:	8b 42 04             	mov    0x4(%edx),%eax
 c22:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 c25:	39 f1                	cmp    %esi,%ecx
 c27:	75 c6                	jne    bef <free+0x3f>
    p->s.size += bp->s.size;
 c29:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 c2c:	89 15 94 11 00 00    	mov    %edx,0x1194
    p->s.size += bp->s.size;
 c32:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 c35:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 c38:	89 0a                	mov    %ecx,(%edx)
}
 c3a:	5b                   	pop    %ebx
 c3b:	5e                   	pop    %esi
 c3c:	5f                   	pop    %edi
 c3d:	5d                   	pop    %ebp
 c3e:	c3                   	ret    
 c3f:	90                   	nop

00000c40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 c40:	55                   	push   %ebp
 c41:	89 e5                	mov    %esp,%ebp
 c43:	57                   	push   %edi
 c44:	56                   	push   %esi
 c45:	53                   	push   %ebx
 c46:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 c4c:	8b 3d 94 11 00 00    	mov    0x1194,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 c52:	8d 70 07             	lea    0x7(%eax),%esi
 c55:	c1 ee 03             	shr    $0x3,%esi
 c58:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 c5b:	85 ff                	test   %edi,%edi
 c5d:	0f 84 9d 00 00 00    	je     d00 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c63:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 c65:	8b 4a 04             	mov    0x4(%edx),%ecx
 c68:	39 f1                	cmp    %esi,%ecx
 c6a:	73 6a                	jae    cd6 <malloc+0x96>
 c6c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 c71:	39 de                	cmp    %ebx,%esi
 c73:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 c76:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 c7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c80:	eb 17                	jmp    c99 <malloc+0x59>
 c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c88:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c8a:	8b 48 04             	mov    0x4(%eax),%ecx
 c8d:	39 f1                	cmp    %esi,%ecx
 c8f:	73 4f                	jae    ce0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c91:	8b 3d 94 11 00 00    	mov    0x1194,%edi
 c97:	89 c2                	mov    %eax,%edx
 c99:	39 d7                	cmp    %edx,%edi
 c9b:	75 eb                	jne    c88 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 c9d:	83 ec 0c             	sub    $0xc,%esp
 ca0:	ff 75 e4             	push   -0x1c(%ebp)
 ca3:	e8 93 fc ff ff       	call   93b <sbrk>
  if(p == (char*)-1)
 ca8:	83 c4 10             	add    $0x10,%esp
 cab:	83 f8 ff             	cmp    $0xffffffff,%eax
 cae:	74 1c                	je     ccc <malloc+0x8c>
  hp->s.size = nu;
 cb0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 cb3:	83 ec 0c             	sub    $0xc,%esp
 cb6:	83 c0 08             	add    $0x8,%eax
 cb9:	50                   	push   %eax
 cba:	e8 f1 fe ff ff       	call   bb0 <free>
  return freep;
 cbf:	8b 15 94 11 00 00    	mov    0x1194,%edx
      if((p = morecore(nunits)) == 0)
 cc5:	83 c4 10             	add    $0x10,%esp
 cc8:	85 d2                	test   %edx,%edx
 cca:	75 bc                	jne    c88 <malloc+0x48>
        return 0;
  }
}
 ccc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 ccf:	31 c0                	xor    %eax,%eax
}
 cd1:	5b                   	pop    %ebx
 cd2:	5e                   	pop    %esi
 cd3:	5f                   	pop    %edi
 cd4:	5d                   	pop    %ebp
 cd5:	c3                   	ret    
    if(p->s.size >= nunits){
 cd6:	89 d0                	mov    %edx,%eax
 cd8:	89 fa                	mov    %edi,%edx
 cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ce0:	39 ce                	cmp    %ecx,%esi
 ce2:	74 4c                	je     d30 <malloc+0xf0>
        p->s.size -= nunits;
 ce4:	29 f1                	sub    %esi,%ecx
 ce6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ce9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 cec:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 cef:	89 15 94 11 00 00    	mov    %edx,0x1194
}
 cf5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 cf8:	83 c0 08             	add    $0x8,%eax
}
 cfb:	5b                   	pop    %ebx
 cfc:	5e                   	pop    %esi
 cfd:	5f                   	pop    %edi
 cfe:	5d                   	pop    %ebp
 cff:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 d00:	c7 05 94 11 00 00 98 	movl   $0x1198,0x1194
 d07:	11 00 00 
    base.s.size = 0;
 d0a:	bf 98 11 00 00       	mov    $0x1198,%edi
    base.s.ptr = freep = prevp = &base;
 d0f:	c7 05 98 11 00 00 98 	movl   $0x1198,0x1198
 d16:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d19:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 d1b:	c7 05 9c 11 00 00 00 	movl   $0x0,0x119c
 d22:	00 00 00 
    if(p->s.size >= nunits){
 d25:	e9 42 ff ff ff       	jmp    c6c <malloc+0x2c>
 d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 d30:	8b 08                	mov    (%eax),%ecx
 d32:	89 0a                	mov    %ecx,(%edx)
 d34:	eb b9                	jmp    cef <malloc+0xaf>
