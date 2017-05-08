/* 
================================================================================
檔案代號:mrak_t
檔案名稱:資源保修零件更換明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrak_t
(
mrakent       number(5)      ,/* 企業編號 */
mraksite       varchar2(10)      ,/* 營運據點 */
mrak001       varchar2(10)      ,/* 資源分類 */
mrak002       varchar2(20)      ,/* 資源編號 */
mrak003       varchar2(10)      ,/* 保修類型 */
mrakseq       number(10,0)      ,/* 保修項次 */
mrakseq1       number(10,0)      ,/* 保修零件項次 */
mrak004       varchar2(40)      ,/* 零件品號 */
mrak005       number(20,6)      ,/* 數量 */
mrak006       varchar2(10)      ,/* 單位 */
mrak007       varchar2(10)      ,/* 舊零件處理方式 */
mrak008       varchar2(255)      ,/* 備註 */
mrakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrak_t add constraint mrak_pk primary key (mrakent,mraksite,mrak001,mrak002,mrak003,mrakseq,mrakseq1) enable validate;

create unique index mrak_pk on mrak_t (mrakent,mraksite,mrak001,mrak002,mrak003,mrakseq,mrakseq1);

grant select on mrak_t to tiptop;
grant update on mrak_t to tiptop;
grant delete on mrak_t to tiptop;
grant insert on mrak_t to tiptop;

exit;
