/* 
================================================================================
檔案代號:prbg_t
檔案名稱:標準調價單明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prbg_t
(
prbgent       number(5)      ,/* 企業編號 */
prbgunit       varchar2(10)      ,/* 應用組織 */
prbgsite       varchar2(10)      ,/* 營運據點 */
prbgdocno       varchar2(20)      ,/* 單據編號 */
prbgseq       number(10,0)      ,/* 項次 */
prbgseq1       number(10,0)      ,/* 序號 */
prbg001       varchar2(10)      ,/* 組織類型 */
prbg002       varchar2(40)      ,/* 商品編號 */
prbg003       varchar2(40)      ,/* 商品主條碼 */
prbg004       varchar2(256)      ,/* 商品特征 */
prbg005       varchar2(10)      ,/* 採購計價單位 */
prbg006       varchar2(10)      ,/* 進項稅別 */
prbg007       number(20,6)      ,/* 進價 */
prbg008       varchar2(10)      ,/* 銷項稅別 */
prbg009       number(20,6)      ,/* 售價 */
prbg010       number(20,6)      ,/* 會員價1 */
prbg011       number(20,6)      ,/* 會員價2 */
prbg012       number(20,6)      ,/* 會員價3 */
prbg013       number(20,6)      ,/* 毛利率 */
prbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prbg014       date      ,/* 進價開始日期 */
prbg015       date      ,/* 進價截止日期 */
prbg016       date      ,/* 售價開始日期 */
prbg017       date      ,/* 售價截止日期 */
prbg018       varchar2(10)      ,/* 銷售計價單位 */
prbg019       date      ,/* 會員價開始日期 */
prbg020       date      ,/* 會員價截止日期 */
prbg021       number(20,6)      ,/* 最新進價 */
prbg022       number(20,6)      ,/* 最近入庫進價 */
prbg023       number(20,6)      ,/* 執行售價 */
prbg024       number(20,6)      ,/* 件裝數 */
prbg025       number(20,6)      ,/* 執行積分單價 */
prbg026       number(20,6)      /* 積分單價 */
);
alter table prbg_t add constraint prbg_pk primary key (prbgent,prbgdocno,prbgseq,prbgseq1) enable validate;

create unique index prbg_pk on prbg_t (prbgent,prbgdocno,prbgseq,prbgseq1);

grant select on prbg_t to tiptop;
grant update on prbg_t to tiptop;
grant delete on prbg_t to tiptop;
grant insert on prbg_t to tiptop;

exit;
