/* 
================================================================================
檔案代號:faan_t
檔案名稱:資產月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table faan_t
(
faanent       number(5)      ,/* 企業編碼 */
faancomp       varchar2(10)      ,/* 法人 */
faansite       varchar2(10)      ,/* 資產中心 */
faan001       number(5,0)      ,/* 年度 */
faan002       number(5,0)      ,/* 月份 */
faan003       varchar2(10)      ,/* 卡片編號 */
faan004       varchar2(20)      ,/* 財產編號 */
faan005       varchar2(20)      ,/* 附號 */
faan006       number(20,6)      ,/* 數量 */
faan007       number(10)      ,/* 資產狀態 */
faan008       number(20,6)      ,/* 外送數量 */
faanld       varchar2(10)      ,/* 帳套 */
faan010       varchar2(10)      ,/* 幣別 */
faan011       number(20,10)      ,/* 匯率 */
faan012       number(10,0)      ,/* 耐用年限 */
faan013       number(10,0)      ,/* 未使用年限 */
faan014       number(20,6)      ,/* 帳面餘額 */
faan015       number(20,6)      ,/* 帳面淨值 */
faan016       number(20,6)      ,/* 帳面價值 */
faan017       number(20,6)      ,/* 本月折舊 */
faan018       number(20,6)      ,/* 累計折舊 */
faan019       number(20,6)      ,/* 已計提減值準備金額 */
faan020       number(20,6)      ,/* 預留殘值 */
faan030       number(20,6)      ,/* 重估數量 */
faan031       number(20,6)      ,/* 重估成本 */
faan032       number(20,6)      ,/* 重估異動累計折舊 */
faan033       number(10,0)      ,/* 重估異動年限 */
faan034       number(20,6)      ,/* 重估異動預留殘值 */
faan035       number(20,6)      ,/* 重估未折減額 */
faan040       number(20,6)      ,/* 內部銷售數量 */
faan041       number(20,6)      ,/* 內部銷售成本 */
faan042       number(20,6)      ,/* 內部銷售累計折舊 */
faan043       number(20,6)      ,/* 內部銷售計提減值準備 */
faan044       number(20,6)      ,/* 內部銷售預留殘值 */
faan045       number(20,6)      ,/* 內部銷售未折減額 */
faan050       number(20,6)      ,/* 銷帳數量 */
faan051       number(20,6)      ,/* 銷帳成本 */
faan052       number(20,6)      ,/* 銷帳累計折舊 */
faan053       number(20,6)      ,/* 銷帳已計提減值準備 */
faan054       number(20,6)      ,/* 銷帳預留殘值 */
faan055       number(20,6)      ,/* 銷帳未折減額 */
faan060       number(20,6)      ,/* 報廢數量 */
faan061       number(20,6)      ,/* 報廢成本 */
faan062       number(20,6)      ,/* 報廢累計折舊 */
faan063       number(20,6)      ,/* 報廢計提減值準備 */
faan064       number(20,6)      ,/* 報廢預留殘值 */
faan065       number(20,6)      ,/* 報廢未折減額 */
faan070       number(20,6)      ,/* 改良數量 */
faan071       number(20,6)      ,/* 改良成本 */
faan072       number(10,0)      ,/* 改良異動未用年限 */
faan073       number(20,6)      ,/* 改良異動預留殘值 */
faan074       number(20,6)      ,/* 改良未折減額 */
faan080       number(20,6)      ,/* 一般銷售數量 */
faan081       number(20,6)      ,/* 一般銷售成本 */
faan082       number(20,6)      ,/* 一般銷售累計折舊 */
faan083       number(20,6)      ,/* 一般銷售計提減值準備 */
faan084       number(20,6)      ,/* 一般銷售預留殘值 */
faan085       number(20,6)      ,/* 一般銷售未折減額 */
faan090       number(20,6)      ,/* 折畢再提預留殘值 */
faan091       number(10,0)      ,/* 折畢再提未用年限 */
faan092       number(20,6)      ,/* 減值準備金額 */
faan100       varchar2(10)      ,/* 本位幣二幣別 */
faan101       number(20,10)      ,/* 本位幣二匯率 */
faan102       number(20,6)      ,/* 本位幣二帳面餘額 */
faan103       number(20,6)      ,/* 本位幣二帳面淨值 */
faan104       number(20,6)      ,/* 本位幣二帳面價值 */
faan105       number(20,6)      ,/* 本位幣二本月折舊 */
faan106       number(20,6)      ,/* 本位幣二累計折舊 */
faan107       number(20,6)      ,/* 本位幣二減值準備金額 */
faan108       number(20,6)      ,/* 本位幣二預留殘值 */
faan120       number(20,6)      ,/* 本位幣二重估成本 */
faan121       number(20,6)      ,/* 本位幣二重估異動累計折舊 */
faan122       number(20,6)      ,/* 本位幣二重估已計提減值準備 */
faan123       number(20,6)      ,/* 本位幣二重估預留殘值 */
faan124       number(20,6)      ,/* 本位幣二重估未折減額 */
faan130       number(20,6)      ,/* 本位幣二內部銷售成本 */
faan131       number(20,6)      ,/* 本位幣二內部銷售累折 */
faan132       number(20,6)      ,/* 本位幣二內部銷售計提減值準備 */
faan133       number(20,6)      ,/* 本位幣二內部銷售預留殘值 */
faan134       number(20,6)      ,/* 本位幣二內部銷售未折減額 */
faan140       number(20,6)      ,/* 本位幣二銷帳成本 */
faan141       number(20,6)      ,/* 本位幣二銷帳累計折舊 */
faan142       number(20,6)      ,/* 本位幣二銷帳已計提減值準備 */
faan143       number(20,6)      ,/* 本位幣二銷帳預留殘值 */
faan144       number(20,6)      ,/* 本位幣二銷帳未折減額 */
faan150       number(20,6)      ,/* 本位幣二報廢成本 */
faan151       number(20,6)      ,/* 本位幣二報廢累計折舊 */
faan152       number(20,6)      ,/* 本位幣二報廢計提減值準備 */
faan153       number(20,6)      ,/* 本位幣二報廢預留殘值 */
faan154       number(20,6)      ,/* 本位幣二報廢未折減額 */
faan160       number(20,6)      ,/* 本位幣二改良成本 */
faan161       number(20,6)      ,/* 本位幣二改良異動預留殘值 */
faan162       number(20,6)      ,/* 本位幣二改良未折減額 */
faan170       number(20,6)      ,/* 本位幣二一般銷售成本 */
faan171       number(20,6)      ,/* 本位幣二一般銷售累計折舊 */
faan172       number(20,6)      ,/* 本位幣二一般銷售計提減值準備 */
faan173       number(20,6)      ,/* 本位幣二一般銷售預留殘值 */
faan174       number(20,6)      ,/* 本位幣二一般銷售未折減額 */
faan190       number(20,6)      ,/* 本位幣二折畢再提預留殘值 */
faan191       number(20,6)      ,/* 本位幣二減值準備金額 */
faan200       varchar2(10)      ,/* 本位幣三幣別 */
faan201       number(20,10)      ,/* 本位幣三匯率 */
faan202       number(20,6)      ,/* 本位幣三帳面餘額 */
faan203       number(20,6)      ,/* 本位幣三帳面淨值 */
faan204       number(20,6)      ,/* 本位幣三帳面價值 */
faan205       number(20,6)      ,/* 本位幣三本月折舊 */
faan206       number(20,6)      ,/* 本位幣三累計折舊 */
faan207       number(20,6)      ,/* 本位幣三減值準備 */
faan208       number(20,6)      ,/* 本位幣三預留殘值 */
faan220       number(20,6)      ,/* 本位幣三重估成本 */
faan221       number(20,6)      ,/* 本位幣三重估異動累計折舊 */
faan222       number(20,6)      ,/* 本位幣二重估已計提減值準備 */
faan223       number(20,6)      ,/* 本位幣三重估異動預留殘值 */
faan224       number(20,6)      ,/* 本位幣三重估後未折減額 */
faan230       number(20,6)      ,/* 本位幣三內部銷售成本 */
faan231       number(20,6)      ,/* 本位幣三內部銷售累折 */
faan232       number(20,6)      ,/* 本位幣三內部銷售計提減值準備 */
faan233       number(20,6)      ,/* 本位幣三內部銷售預留殘值 */
faan234       number(20,6)      ,/* 本位幣三內部銷售未折減額 */
faan240       number(20,6)      ,/* 本位幣三銷帳成本 */
faan241       number(20,6)      ,/* 本位幣三銷帳累折 */
faan242       number(20,6)      ,/* 本位幣三銷帳計提減值準備 */
faan243       number(20,6)      ,/* 本位幣三銷帳預留殘值 */
faan244       number(20,6)      ,/* 本位幣三銷帳未折減額 */
faan250       number(20,6)      ,/* 本位幣三報廢成本 */
faan251       number(20,6)      ,/* 本位幣三報廢累折 */
faan252       number(20,6)      ,/* 本位幣三報廢計提減值準備 */
faan253       number(20,6)      ,/* 本位幣三報廢預留殘值 */
faan254       number(20,6)      ,/* 本位幣三報廢未折減額 */
faan260       number(20,6)      ,/* 本位幣三改良成本 */
faan261       number(20,6)      ,/* 本位幣三改良異動預留殘值 */
faan262       number(20,6)      ,/* 本位幣三改良未折減額 */
faan270       number(20,6)      ,/* 本位幣三一般銷售成本 */
faan271       number(20,6)      ,/* 本位幣三一般銷售累折 */
faan272       number(20,6)      ,/* 本位幣三一般銷售計提減值準備 */
faan273       number(20,6)      ,/* 本位幣三一般銷售預留殘值 */
faan274       number(20,6)      ,/* 本位幣三一般銷售未折減額 */
faan290       number(20,6)      ,/* 本位幣三折畢再提預留殘值 */
faan291       number(20,6)      /* 本位幣三減值準備金額 */
);
alter table faan_t add constraint faan_pk primary key (faanent,faan001,faan002,faan003,faan004,faan005,faanld) enable validate;

create unique index faan_pk on faan_t (faanent,faan001,faan002,faan003,faan004,faan005,faanld);

grant select on faan_t to tiptop;
grant update on faan_t to tiptop;
grant delete on faan_t to tiptop;
grant insert on faan_t to tiptop;

exit;
