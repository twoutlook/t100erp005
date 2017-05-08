/* 
================================================================================
檔案代號:prbj_t
檔案名稱:生鮮調價單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbj_t
(
prbjent       number(5)      ,/* 企業編號 */
prbjunit       varchar2(10)      ,/* 應用組織 */
prbjsite       varchar2(10)      ,/* 營運據點 */
prbjdocno       varchar2(20)      ,/* 單據編號 */
prbjseq       number(10,0)      ,/* 項次 */
prbjseq1       number(10,0)      ,/* 序號 */
prbj001       varchar2(40)      ,/* 商品編號 */
prbj002       varchar2(40)      ,/* 商品條碼 */
prbj003       varchar2(256)      ,/* 商品特征 */
prbj004       varchar2(10)      ,/* PLU碼 */
prbj005       varchar2(10)      ,/* 包裝單位 */
prbj006       number(20,6)      ,/* 整包件數 */
prbj007       number(5,0)      ,/* 價格因子 */
prbj008       varchar2(10)      ,/* 進項稅別 */
prbj009       number(20,6)      ,/* 進價 */
prbj010       varchar2(10)      ,/* 銷項稅別 */
prbj011       number(20,6)      ,/* 售價 */
prbj012       number(20,6)      ,/* 會員價1 */
prbj013       number(20,6)      ,/* 會員價2 */
prbj014       number(20,6)      ,/* 會員價3 */
prbj015       number(20,6)      ,/* 毛利率 */
prbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbj016       date      ,/* 進價開始日期 */
prbj017       date      ,/* 進價截止日期 */
prbj018       date      ,/* 售價開始日期 */
prbj019       date      /* 售價截止日期 */
);
alter table prbj_t add constraint prbj_pk primary key (prbjent,prbjdocno,prbjseq,prbjseq1) enable validate;

create unique index prbj_pk on prbj_t (prbjent,prbjdocno,prbjseq,prbjseq1);

grant select on prbj_t to tiptop;
grant update on prbj_t to tiptop;
grant delete on prbj_t to tiptop;
grant insert on prbj_t to tiptop;

exit;
