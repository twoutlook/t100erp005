/* 
================================================================================
檔案代號:inab_t
檔案名稱:儲位基本資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inab_t
(
inabent       number(5)      ,/* 企業編號 */
inabsite       varchar2(10)      ,/* 營運據點 */
inab001       varchar2(10)      ,/* 庫位編號 */
inab002       varchar2(10)      ,/* 儲位編號 */
inab003       varchar2(500)      ,/* 儲位名稱 */
inab004       varchar2(10)      ,/* 助記碼 */
inab005       number(5,0)      ,/* 揀料優先順序 */
inab006       varchar2(1)      ,/* 庫存可用否 */
inab007       varchar2(1)      ,/* MRP可用否 */
inab008       varchar2(256)      ,/* Tag二進位碼 */
inabstus       varchar2(10)      ,/* 狀態碼 */
inabownid       varchar2(20)      ,/* 資料所有者 */
inabowndp       varchar2(10)      ,/* 資料所屬部門 */
inabcrtid       varchar2(20)      ,/* 資料建立者 */
inabcrtdp       varchar2(10)      ,/* 資料建立部門 */
inabcrtdt       timestamp(0)      ,/* 資料創建日 */
inabmodid       varchar2(20)      ,/* 資料修改者 */
inabmoddt       timestamp(0)      ,/* 最近修改日 */
inabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inabud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inab_t add constraint inab_pk primary key (inabent,inabsite,inab001,inab002) enable validate;

create  index inab_01 on inab_t (inab008);
create unique index inab_pk on inab_t (inabent,inabsite,inab001,inab002);

grant select on inab_t to tiptop;
grant update on inab_t to tiptop;
grant delete on inab_t to tiptop;
grant insert on inab_t to tiptop;

exit;
