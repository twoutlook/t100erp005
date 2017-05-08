/* 
================================================================================
檔案代號:mmap_t
檔案名稱:生效營運據點設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmap_t
(
mmapent       number(5)      ,/* 企業編號 */
mmap001       varchar2(20)      ,/* 程式編號 */
mmap002       varchar2(10)      ,/* 卡種/券種 */
mmap003       varchar2(10)      ,/* 生效營運據點 */
mmap004       number(20,6)      ,/* 卡/券安全庫量 */
mmap005       varchar2(1)      ,/* 包括組織以下所有營運據點 */
mmap006       varchar2(1)      ,/* 上級發佈卡儲值規則自行確認 */
mmap007       varchar2(1)      ,/* 上級發佈卡積點規則自行確認 */
mmapstus       varchar2(10)      ,/* 有效 */
mmapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmap_t add constraint mmap_pk primary key (mmapent,mmap001,mmap002,mmap003) enable validate;

create unique index mmap_pk on mmap_t (mmapent,mmap001,mmap002,mmap003);

grant select on mmap_t to tiptop;
grant update on mmap_t to tiptop;
grant delete on mmap_t to tiptop;
grant insert on mmap_t to tiptop;

exit;
