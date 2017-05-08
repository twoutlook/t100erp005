/* 
================================================================================
檔案代號:mrdi_t
檔案名稱:資源維修加工單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrdi_t
(
mrdient       number(5)      ,/* 企業編號 */
mrdisite       varchar2(10)      ,/* 營運據點 */
mrdidocno       varchar2(20)      ,/* 維修工單單號 */
mrdiseq       number(10,0)      ,/* 項次 */
mrdi001       varchar2(500)      ,/* 加工說明 */
mrdi002       varchar2(10)      ,/* 廠商/部門 */
mrdi003       number(15,3)      ,/* 工時 */
mrdi004       number(20,6)      ,/* 工資率 */
mrdi005       number(20,6)      ,/* 單價 */
mrdi006       varchar2(20)      ,/* 參考單號 */
mrdi007       varchar2(10)      ,/* 參考作業編號 */
mrdi008       varchar2(20)      ,/* 參考機器編號 */
mrdi009       varchar2(255)      ,/* 備註 */
mrdiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdi_t add constraint mrdi_pk primary key (mrdient,mrdidocno,mrdiseq) enable validate;

create unique index mrdi_pk on mrdi_t (mrdient,mrdidocno,mrdiseq);

grant select on mrdi_t to tiptop;
grant update on mrdi_t to tiptop;
grant delete on mrdi_t to tiptop;
grant insert on mrdi_t to tiptop;

exit;
