/* 
================================================================================
檔案代號:inds_t
檔案名稱:批號數量更正單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inds_t
(
indsent       number(5)      ,/* 企業編號 */
indssite       varchar2(10)      ,/* 營運組織 */
indsunit       varchar2(10)      ,/* 應用組織 */
indsdocno       varchar2(20)      ,/* 單號 */
indsseq       number(10,0)      ,/* 項次 */
indsseq1       number(10,0)      ,/* 項序 */
inds001       varchar2(30)      ,/* 批號 */
inds002       varchar2(10)      ,/* 儲位 */
inds003       varchar2(10)      ,/* 庫區編號 */
inds004       varchar2(40)      ,/* 商品編號 */
inds005       varchar2(40)      ,/* 商品條碼 */
inds006       varchar2(10)      ,/* 庫存單位 */
inds007       number(20,6)      ,/* 批號現有數量 */
inds008       number(20,6)      ,/* 增減數量 */
inds009       number(20,6)      ,/* 批號新數量 */
inds010       number(20,6)      ,/* 批號原進價 */
inds011       number(20,6)      ,/* 批號新進價 */
inds012       number(20,6)      ,/* No Use */
inds013       number(20,6)      ,/* No Use */
inds014       varchar2(10)      ,/* 供應商編號 */
inds015       varchar2(20)      ,/* 合約編號 */
inds016       varchar2(20)      ,/* 虛擬入庫單號 */
inds017       number(10,0)      ,/* 虛擬入庫項次 */
inds018       varchar2(20)      ,/* 虛擬退廠單號 */
inds019       number(10,0)      ,/* 虛擬退廠項次 */
inds020       varchar2(256)      ,/* 產品特徵 */
inds021       varchar2(30)      ,/* 庫存管理特徵 */
indsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
indsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
indsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
indsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
indsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
indsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
indsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
indsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
indsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
indsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
indsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
indsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
indsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
indsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
indsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
indsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
indsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
indsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
indsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
indsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
indsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
indsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
indsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
indsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
indsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
indsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
indsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
indsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
indsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
indsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inds_t add constraint inds_pk primary key (indsent,indsdocno,indsseq,indsseq1) enable validate;

create unique index inds_pk on inds_t (indsent,indsdocno,indsseq,indsseq1);

grant select on inds_t to tiptop;
grant update on inds_t to tiptop;
grant delete on inds_t to tiptop;
grant insert on inds_t to tiptop;

exit;
