/* 
================================================================================
檔案代號:prcl_t
檔案名稱:促銷產品數量申請明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prcl_t
(
prclent       number(5)      ,/* 企業編號 */
prclunit       varchar2(10)      ,/* 應用組織 */
prclsite       varchar2(10)      ,/* 營運據點 */
prcldocno       varchar2(20)      ,/* 單據編號 */
prclseq       number(10,0)      ,/* 項次 */
prcl001       varchar2(10)      ,/* 對象類別 */
prcl002       varchar2(10)      ,/* 經銷商 */
prcl003       varchar2(10)      ,/* 網點 */
prcl004       varchar2(10)      ,/* 銷售範圍 */
prcl005       varchar2(10)      ,/* 銷售通路 */
prcl006       varchar2(10)      ,/* 辦事處 */
prcl007       varchar2(10)      ,/* 產品組 */
prcl008       varchar2(40)      ,/* 產品編號 */
prcl009       varchar2(10)      ,/* 包裝單位 */
prcl010       number(20,6)      ,/* 申請數量 */
prcl011       number(20,6)      ,/* 分配數量 */
prcl012       number(20,6)      ,/* 返利比例 */
prcl013       number(20,6)      ,/* 超任務量返利比例 */
prcl014       number(20,6)      ,/* 承擔比例 */
prcl015       varchar2(10)      ,/* 分配狀態 */
prcl016       varchar2(40)      ,/* 產品條碼 */
prclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcl_t add constraint prcl_pk primary key (prclent,prcldocno,prclseq) enable validate;

create unique index prcl_pk on prcl_t (prclent,prcldocno,prclseq);

grant select on prcl_t to tiptop;
grant update on prcl_t to tiptop;
grant delete on prcl_t to tiptop;
grant insert on prcl_t to tiptop;

exit;
