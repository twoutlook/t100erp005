/* 
================================================================================
檔案代號:gzbc_t
檔案名稱:節點關聯資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzbc_t
(
gzbc001       varchar2(40)      ,/* 來源節點代號 */
gzbc002       varchar2(40)      ,/* 目的節點代號 */
gzbc003       varchar2(40)      ,/* 分類代號 */
gzbc004       varchar2(255)      ,/* 其它資訊 */
gzbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzbc_t add constraint gzbc_pk primary key (gzbc001,gzbc002,gzbc003) enable validate;

create unique index gzbc_pk on gzbc_t (gzbc001,gzbc002,gzbc003);

grant select on gzbc_t to tiptop;
grant update on gzbc_t to tiptop;
grant delete on gzbc_t to tiptop;
grant insert on gzbc_t to tiptop;

exit;
