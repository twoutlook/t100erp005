/* 
================================================================================
檔案代號:prch_t
檔案名稱:促銷任務量申請明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prch_t
(
prchent       number(5)      ,/* 企業編號 */
prchunit       varchar2(10)      ,/* 應用組織 */
prchsite       varchar2(10)      ,/* 營運據點 */
prchdocno       varchar2(20)      ,/* 單據編號 */
prchseq       number(10,0)      ,/* 項次 */
prch001       varchar2(10)      ,/* 對象類型 */
prch002       varchar2(10)      ,/* 經銷商 */
prch003       varchar2(10)      ,/* 網點 */
prch004       varchar2(10)      ,/* 銷售範圍 */
prch005       varchar2(10)      ,/* 銷售通路 */
prch006       varchar2(10)      ,/* 辦事處 */
prch007       varchar2(10)      ,/* 產品組 */
prch008       number(20,6)      ,/* 申請任務量 */
prch009       number(20,6)      ,/* 分配任務量 */
prch010       number(20,6)      ,/* 返利比例 */
prch011       number(20,6)      ,/* 超任務量返利比例 */
prch012       number(20,6)      ,/* 承擔比例 */
prch013       varchar2(10)      ,/* 分配狀態 */
prchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prch_t add constraint prch_pk primary key (prchent,prchdocno,prchseq) enable validate;

create unique index prch_pk on prch_t (prchent,prchdocno,prchseq);

grant select on prch_t to tiptop;
grant update on prch_t to tiptop;
grant delete on prch_t to tiptop;
grant insert on prch_t to tiptop;

exit;
