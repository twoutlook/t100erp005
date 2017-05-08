/* 
================================================================================
檔案代號:pcbc_t
檔案名稱:觸屏分類資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcbc_t
(
pcbcent       number(5)      ,/* 企業編號 */
pcbc001       varchar2(10)      ,/* 方案編號 */
pcbc002       varchar2(10)      ,/* 分類類型 */
pcbc003       varchar2(10)      ,/* 分類編號 */
pcbc004       varchar2(10)      ,/* 上級分類 */
pcbc005       number(5,0)      ,/* 順序號 */
pcbcstus       varchar2(10)      ,/* 狀態碼 */
pcbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcbcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcbc_t add constraint pcbc_pk primary key (pcbcent,pcbc001,pcbc003) enable validate;

create unique index pcbc_pk on pcbc_t (pcbcent,pcbc001,pcbc003);

grant select on pcbc_t to tiptop;
grant update on pcbc_t to tiptop;
grant delete on pcbc_t to tiptop;
grant insert on pcbc_t to tiptop;

exit;
