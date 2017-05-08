/* 
================================================================================
檔案代號:mrza_t
檔案名稱:資源異動記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrza_t
(
mrzaent       number(5)      ,/* 企業編號 */
mrzasite       varchar2(10)      ,/* 營運據點 */
mrza001       varchar2(20)      ,/* 異動單號 */
mrza002       number(10,0)      ,/* 異動項次 */
mrza003       date      ,/* 異動日期 */
mrza004       varchar2(20)      ,/* 資源編號 */
mrza005       varchar2(20)      ,/* 異動作業 */
mrza006       number(20,6)      ,/* 數量 */
mrza007       number(10,0)      ,/* 異動類型 */
mrza008       number(20,6)      ,/* 異動成本 */
mrza009       varchar2(80)      ,/* 備註 */
mrzaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrzaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrzaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrzaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrzaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrzaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrzaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrzaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrzaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrzaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrzaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrzaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrzaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrzaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrzaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrzaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrzaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrzaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrzaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrzaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrzaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrzaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrzaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrzaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrzaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrzaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrzaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrzaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrzaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrzaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrza_t add constraint mrza_pk primary key (mrzaent,mrza001,mrza002) enable validate;

create unique index mrza_pk on mrza_t (mrzaent,mrza001,mrza002);

grant select on mrza_t to tiptop;
grant update on mrza_t to tiptop;
grant delete on mrza_t to tiptop;
grant insert on mrza_t to tiptop;

exit;
