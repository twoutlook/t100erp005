/* 
================================================================================
檔案代號:inam_t
檔案名稱:料件產品特徵明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inam_t
(
inament       number(5)      ,/* 企業編號 */
inam001       varchar2(40)      ,/* 料件編號 */
inam002       varchar2(256)      ,/* 產品特徵 */
inam003       varchar2(10)      ,/* 特徵群組 */
inam004       number(20,6)      ,/* 備置數量 */
inam005       varchar2(10)      ,/* 建立營運據點 */
inam006       varchar2(20)      ,/* 建立來源單號 */
inam007       date      ,/* 建立日期 */
inam011       varchar2(10)      ,/* 特徵一類型 */
inam012       varchar2(30)      ,/* 特徵一值 */
inam013       varchar2(10)      ,/* 特徵二類型 */
inam014       varchar2(30)      ,/* 特徵二值 */
inam015       varchar2(10)      ,/* 特徵三類型 */
inam016       varchar2(30)      ,/* 特徵三值 */
inam017       varchar2(10)      ,/* 特徵四類型 */
inam018       varchar2(30)      ,/* 特徵四值 */
inam019       varchar2(10)      ,/* 特徵五類型 */
inam020       varchar2(30)      ,/* 特徵五值 */
inam021       varchar2(10)      ,/* 特徵六類型 */
inam022       varchar2(30)      ,/* 特徵六值 */
inam023       varchar2(10)      ,/* 特徵七類型 */
inam024       varchar2(30)      ,/* 特徵七值 */
inam025       varchar2(10)      ,/* 特徵八類型 */
inam026       varchar2(30)      ,/* 特徵八值 */
inam027       varchar2(10)      ,/* 特徵九類型 */
inam028       varchar2(30)      ,/* 特徵九值 */
inam029       varchar2(10)      ,/* 特徵十類型 */
inam030       varchar2(30)      ,/* 特徵十值 */
inam031       varchar2(10)      ,/* 特徵十一類型 */
inam032       varchar2(30)      ,/* 特徵十一值 */
inam033       varchar2(10)      ,/* 特徵十二類型 */
inam034       varchar2(30)      ,/* 特徵十二值 */
inam035       varchar2(10)      ,/* 特徵十三類型 */
inam036       varchar2(30)      ,/* 特徵十三值 */
inam037       varchar2(10)      ,/* 特徵十四類型 */
inam038       varchar2(30)      ,/* 特徵十四值 */
inam039       varchar2(10)      ,/* 特徵十五類型 */
inam040       varchar2(30)      ,/* 特徵十五值 */
inam041       varchar2(10)      ,/* 特徵十六類型 */
inam042       varchar2(30)      ,/* 特徵十六值 */
inam043       varchar2(10)      ,/* 特徵十七類型 */
inam044       varchar2(30)      ,/* 特徵十七值 */
inam045       varchar2(10)      ,/* 特徵十八類型 */
inam046       varchar2(30)      ,/* 特徵十八值 */
inam047       varchar2(10)      ,/* 特徵十九類型 */
inam048       varchar2(30)      ,/* 特徵十九值 */
inam049       varchar2(10)      ,/* 特徵二十類型 */
inam050       varchar2(30)      /* 特徵二十值 */
);
alter table inam_t add constraint inam_pk primary key (inament,inam001,inam002) enable validate;

create unique index inam_pk on inam_t (inament,inam001,inam002);

grant select on inam_t to tiptop;
grant update on inam_t to tiptop;
grant delete on inam_t to tiptop;
grant insert on inam_t to tiptop;

exit;
