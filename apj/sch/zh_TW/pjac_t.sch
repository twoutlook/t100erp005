/* 
================================================================================
檔案代號:pjac_t
檔案名稱:專案報價單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pjac_t
(
pjacent       number(5)      ,/* 企業編號 */
pjac000       varchar2(10)      ,/* 專案類型 */
pjac001       varchar2(20)      ,/* 專案編號 */
pjac002       number(10,0)      ,/* 報價版本 */
pjac003       varchar2(20)      ,/* 報價單號 */
pjac004       date      ,/* 報價日期 */
pjac005       varchar2(10)      ,/* 報價幣別 */
pjac006       varchar2(10)      ,/* 稅別 */
pjac007       varchar2(80)      ,/* 業主聯絡人 */
pjac008       varchar2(80)      ,/* 業主聯絡電話 */
pjac009       varchar2(255)      ,/* 備註 */
pjac010       number(20,10)      ,/* 匯率 */
pjacownid       varchar2(20)      ,/* 資料所屬者 */
pjacowndp       varchar2(10)      ,/* 資料所有部門 */
pjaccrtid       varchar2(20)      ,/* 資料建立者 */
pjaccrtdp       varchar2(10)      ,/* 資料建立部門 */
pjaccrtdt       timestamp(0)      ,/* 資料創建日 */
pjacmodid       varchar2(20)      ,/* 資料修改者 */
pjacmoddt       timestamp(0)      ,/* 最近修改日 */
pjaccnfid       varchar2(20)      ,/* 資料確認者 */
pjaccnfdt       timestamp(0)      ,/* 資料確認日 */
pjacstus       varchar2(10)      ,/* 狀態碼 */
pjacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjac011       number(5,2)      /* 稅率 */
);
alter table pjac_t add constraint pjac_pk primary key (pjacent,pjac001,pjac002) enable validate;

create unique index pjac_pk on pjac_t (pjacent,pjac001,pjac002);

grant select on pjac_t to tiptop;
grant update on pjac_t to tiptop;
grant delete on pjac_t to tiptop;
grant insert on pjac_t to tiptop;

exit;
