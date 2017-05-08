/* 
================================================================================
檔案代號:prcj_t
檔案名稱:促銷任務量分配明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prcj_t
(
prcjent       number(5)      ,/* 企業編號 */
prcjunit       varchar2(10)      ,/* 應用組織 */
prcjsite       varchar2(10)      ,/* 營運據點 */
prcjdocno       varchar2(20)      ,/* 單據編號 */
prcjseq       number(10,0)      ,/* 項次 */
prcj001       varchar2(20)      ,/* 申請單號 */
prcj002       number(10,0)      ,/* 申請項次 */
prcj003       varchar2(10)      ,/* 對象類型 */
prcj004       varchar2(10)      ,/* 經銷商 */
prcj005       varchar2(10)      ,/* 網點 */
prcj006       varchar2(10)      ,/* 銷售範圍 */
prcj007       varchar2(10)      ,/* 銷售通路 */
prcj008       varchar2(10)      ,/* 辦事處 */
prcj009       varchar2(10)      ,/* 產品組 */
prcj010       number(20,6)      ,/* 申請任務量 */
prcj011       number(20,6)      ,/* 分配任務量 */
prcj012       number(20,6)      ,/* 返利比例 */
prcj013       number(20,6)      ,/* 超任務量返利比例 */
prcj014       number(20,6)      ,/* 承擔比例 */
prcjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcj_t add constraint prcj_pk primary key (prcjent,prcjdocno,prcjseq) enable validate;

create unique index prcj_pk on prcj_t (prcjent,prcjdocno,prcjseq);

grant select on prcj_t to tiptop;
grant update on prcj_t to tiptop;
grant delete on prcj_t to tiptop;
grant insert on prcj_t to tiptop;

exit;
