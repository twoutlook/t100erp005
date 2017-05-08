/* 
================================================================================
檔案代號:psce_t
檔案名稱:APS版本限制條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table psce_t
(
psceent       number(5)      ,/* 企業編號 */
pscesite       varchar2(10)      ,/* 營運據點 */
psce001       varchar2(10)      ,/* APS版本 */
psce002       varchar2(10)      ,/* 供給法則編號 */
psce003       number(5,0)      ,/* 順序 */
psceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psce_t add constraint psce_pk primary key (psceent,pscesite,psce001,psce002) enable validate;

create unique index psce_pk on psce_t (psceent,pscesite,psce001,psce002);

grant select on psce_t to tiptop;
grant update on psce_t to tiptop;
grant delete on psce_t to tiptop;
grant insert on psce_t to tiptop;

exit;
