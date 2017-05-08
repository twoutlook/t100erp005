/* 
================================================================================
檔案代號:inac_t
檔案名稱:庫位/儲位庫存標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inac_t
(
inacent       number(5)      ,/* 企業編號 */
inacsite       varchar2(10)      ,/* 營運據點 */
inac001       varchar2(10)      ,/* 庫位編號 */
inac002       varchar2(10)      ,/* 儲位編號 */
inac003       varchar2(10)      ,/* 標籤編號 */
inacstus       varchar2(10)      ,/* 狀態碼 */
inacownid       varchar2(20)      ,/* 資料所有者 */
inacowndp       varchar2(10)      ,/* 資料所屬部門 */
inaccrtid       varchar2(20)      ,/* 資料建立者 */
inaccrtdp       varchar2(10)      ,/* 資料建立部門 */
inaccrtdt       timestamp(0)      ,/* 資料創建日 */
inacmodid       varchar2(20)      ,/* 資料修改者 */
inacmoddt       timestamp(0)      ,/* 最近修改日 */
inacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inacud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inac_t add constraint inac_pk primary key (inacent,inacsite,inac001,inac002,inac003) enable validate;

create unique index inac_pk on inac_t (inacent,inacsite,inac001,inac002,inac003);

grant select on inac_t to tiptop;
grant update on inac_t to tiptop;
grant delete on inac_t to tiptop;
grant insert on inac_t to tiptop;

exit;
