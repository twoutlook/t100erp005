/* 
================================================================================
檔案代號:mmbx_t
檔案名稱:卡活動規則生效營運據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmbx_t
(
mmbxent       number(5)      ,/* 企業編號 */
mmbx001       varchar2(30)      ,/* 活動規則編號 */
mmbx002       varchar2(10)      ,/* 活動類型 */
mmbx003       varchar2(10)      ,/* 卡種編號 */
mmbx004       varchar2(10)      ,/* 生效營運據點 */
mmbx005       varchar2(1)      ,/* 包含以下營運組織 */
mmbxstus       varchar2(1)      ,/* 資料有效 */
mmbxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbx_t add constraint mmbx_pk primary key (mmbxent,mmbx001,mmbx004) enable validate;

create unique index mmbx_pk on mmbx_t (mmbxent,mmbx001,mmbx004);

grant select on mmbx_t to tiptop;
grant update on mmbx_t to tiptop;
grant delete on mmbx_t to tiptop;
grant insert on mmbx_t to tiptop;

exit;
