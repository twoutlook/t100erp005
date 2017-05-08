/* 
================================================================================
檔案代號:pcas_t
檔案名稱:POS日結明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcas_t
(
pcasent       number(5)      ,/* 企業編號 */
pcassite       varchar2(10)      ,/* 營運組織 */
pcas001       date      ,/* 日結日期 */
pcas002       varchar2(10)      ,/* 單據類型 */
pcas003       number(10,0)      ,/* 單據筆數 */
pcas004       number(20,6)      ,/* 單據金額 */
pcasstus       varchar2(10)      ,/* 狀態 */
pcasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcas_t add constraint pcas_pk primary key (pcasent,pcassite,pcas001,pcas002) enable validate;

create unique index pcas_pk on pcas_t (pcasent,pcassite,pcas001,pcas002);

grant select on pcas_t to tiptop;
grant update on pcas_t to tiptop;
grant delete on pcas_t to tiptop;
grant insert on pcas_t to tiptop;

exit;
