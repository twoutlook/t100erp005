/* 
================================================================================
檔案代號:oobc_t
檔案名稱:單據別控制組限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobc_t
(
oobcent       number(5)      ,/* 企業編號 */
oobc001       varchar2(5)      ,/* 參照表號 */
oobc002       varchar2(5)      ,/* 單據別 */
oobc003       varchar2(10)      ,/* 控制組編號 */
oobcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
oobc004       varchar2(10)      /* 控制組類型 */
);
alter table oobc_t add constraint oobc_pk primary key (oobcent,oobc001,oobc002,oobc003) enable validate;

create unique index oobc_pk on oobc_t (oobcent,oobc001,oobc002,oobc003);

grant select on oobc_t to tiptop;
grant update on oobc_t to tiptop;
grant delete on oobc_t to tiptop;
grant insert on oobc_t to tiptop;

exit;
