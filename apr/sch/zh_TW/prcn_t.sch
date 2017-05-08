/* 
================================================================================
檔案代號:prcn_t
檔案名稱:促銷任務量分配明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prcn_t
(
prcnent       number(5)      ,/* 企業編號 */
prcnunit       varchar2(10)      ,/* 應用組織 */
prcnsite       varchar2(10)      ,/* 營運據點 */
prcndocno       varchar2(20)      ,/* 單據編號 */
prcnseq       number(10,0)      ,/* 項次 */
prcn001       varchar2(20)      ,/* 申請單號 */
prcn002       number(10,0)      ,/* 申請項次 */
prcn003       varchar2(10)      ,/* 對象類別 */
prcn004       varchar2(10)      ,/* 經銷商 */
prcn005       varchar2(10)      ,/* 網點 */
prcn006       varchar2(10)      ,/* 銷售範圍 */
prcn007       varchar2(10)      ,/* 銷售通路 */
prcn008       varchar2(10)      ,/* 辦事處 */
prcn009       varchar2(10)      ,/* 產品組 */
prcn010       varchar2(40)      ,/* 產品編號 */
prcn011       varchar2(10)      ,/* 包裝單位 */
prcn012       number(20,6)      ,/* 申請任務量 */
prcn013       number(20,6)      ,/* 分配任務量 */
prcn014       number(20,6)      ,/* 返利比例 */
prcn015       number(20,6)      ,/* 超任務返利比例 */
prcn016       number(20,6)      ,/* 承擔比例 */
prcn017       varchar2(256)      ,/* 特徵碼 */
prcn018       varchar2(40)      ,/* 商品條碼 */
prcnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prcn_t add constraint prcn_pk primary key (prcnent,prcndocno,prcnseq) enable validate;

create unique index prcn_pk on prcn_t (prcnent,prcndocno,prcnseq);

grant select on prcn_t to tiptop;
grant update on prcn_t to tiptop;
grant delete on prcn_t to tiptop;
grant insert on prcn_t to tiptop;

exit;
