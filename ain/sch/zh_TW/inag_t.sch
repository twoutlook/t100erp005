/* 
================================================================================
檔案代號:inag_t
檔案名稱:庫存明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inag_t
(
inagent       number(5)      ,/* 企業編號 */
inagsite       varchar2(10)      ,/* 營運據點 */
inag001       varchar2(40)      ,/* 料件編號 */
inag002       varchar2(256)      ,/* 產品特徵 */
inag003       varchar2(30)      ,/* 庫存管理特徵 */
inag004       varchar2(10)      ,/* 庫位編號 */
inag005       varchar2(10)      ,/* 儲位編號 */
inag006       varchar2(30)      ,/* 批號 */
inag007       varchar2(10)      ,/* 庫存單位 */
inag008       number(20,6)      ,/* 帳面庫存數量 */
inag009       number(20,6)      ,/* 實際庫存數量 */
inag010       varchar2(1)      ,/* 庫存可用否 */
inag011       varchar2(1)      ,/* MRP可用否 */
inag012       varchar2(1)      ,/* 成本庫否 */
inag013       number(5,0)      ,/* 揀貨優先序 */
inag014       date      ,/* 最近一次盤點日期 */
inag015       date      ,/* 最後異動日期 */
inag016       date      ,/* 呆滯日期 */
inag017       date      ,/* 第一次入庫日期 */
inag018       date      ,/* No Use */
inag019       varchar2(1)      ,/* 留置否 */
inag020       varchar2(10)      ,/* 留置原因 */
inag021       number(20,6)      ,/* 備置數量 */
inag022       varchar2(255)      ,/* No Use */
inag023       varchar2(256)      ,/* Tag二進位碼 */
inag024       varchar2(10)      ,/* 參考單位 */
inag025       number(20,6)      ,/* 參考數量 */
inag026       date      ,/* 最近一次檢驗日期 */
inag027       date      ,/* 下次檢驗日期 */
inag028       date      ,/* 留置日期 */
inag029       varchar2(20)      ,/* 留置人員 */
inag030       varchar2(10)      ,/* 留置部門 */
inag031       varchar2(20)      ,/* 留置單號 */
inag032       varchar2(10)      ,/* 基礎單位 */
inag033       number(20,6)      /* 基礎單位數量 */
);
alter table inag_t add constraint inag_pk primary key (inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007) enable validate;

create  index inag_01 on inag_t (inag023);
create unique index inag_pk on inag_t (inagent,inagsite,inag001,inag002,inag003,inag004,inag005,inag006,inag007);

grant select on inag_t to tiptop;
grant update on inag_t to tiptop;
grant delete on inag_t to tiptop;
grant insert on inag_t to tiptop;

exit;
