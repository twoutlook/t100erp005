/* 
================================================================================
檔案代號:pcbe_t
檔案名稱:觸屏生效範圍資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pcbe_t
(
pcbeent       number(5)      ,/* 企業編號 */
pcbe001       varchar2(10)      ,/* 方案編號 */
pcbe002       varchar2(10)      ,/* 生效營運據點 */
pcbestus       varchar2(10)      ,/* 狀態碼 */
pcbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcbe_t add constraint pcbe_pk primary key (pcbeent,pcbe001,pcbe002) enable validate;

create unique index pcbe_pk on pcbe_t (pcbeent,pcbe001,pcbe002);

grant select on pcbe_t to tiptop;
grant update on pcbe_t to tiptop;
grant delete on pcbe_t to tiptop;
grant insert on pcbe_t to tiptop;

exit;
