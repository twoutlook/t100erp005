/* 
================================================================================
檔案代號:fmng_t
檔案名稱:計提收益帳務單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmng_t
(
fmngent       number(5)      ,/* 企業編號 */
fmngdocno       varchar2(20)      ,/* 單據編號 */
fmngseq       number(10,0)      ,/* 項次 */
fmng001       varchar2(10)      ,/* 投資組織 */
fmng002       varchar2(20)      ,/* 投資單號 */
fmng003       varchar2(10)      ,/* 幣別 */
fmng004       number(20,6)      ,/* 本金 */
fmng005       number(20,6)      ,/* 本期計提金額 */
fmng006       number(20,6)      ,/* 利息調整 */
fmng007       number(20,6)      ,/* 投資收益 */
fmng008       number(20,10)      ,/* 匯率一 */
fmng009       number(20,6)      ,/* 本幣一計提金額 */
fmng010       number(20,6)      ,/* 本幣一利息調整 */
fmng011       number(20,6)      ,/* 本幣一投資收益 */
fmng012       number(20,10)      ,/* 匯率二 */
fmng013       number(20,6)      ,/* 本幣二計提金額 */
fmng014       number(20,6)      ,/* 本幣二利息調整 */
fmng015       number(20,6)      ,/* 本幣二投資收益 */
fmng016       number(20,10)      ,/* 匯率三 */
fmng017       number(20,6)      ,/* 本幣三計提金額 */
fmng018       number(20,6)      ,/* 本幣三利息調整 */
fmng019       number(20,6)      ,/* 本幣三投資收益 */
fmng020       varchar2(24)      ,/* 應收股利/利息科目DR */
fmng021       varchar2(24)      ,/* 利息調整科目 */
fmng022       varchar2(24)      ,/* 投資收益科目CR */
fmng023       varchar2(10)      ,/* 帳款對象 */
fmng024       varchar2(10)      ,/* 收款對象 */
fmng025       varchar2(10)      ,/* 部門 */
fmng026       varchar2(10)      ,/* 利潤中心 */
fmng027       varchar2(10)      ,/* 區域 */
fmng028       varchar2(10)      ,/* 客群 */
fmng029       varchar2(10)      ,/* 產品類別 */
fmng030       varchar2(20)      ,/* 人員 */
fmng031       varchar2(20)      ,/* 專案代號 */
fmng032       varchar2(30)      ,/* WBS編號 */
fmng033       varchar2(10)      ,/* 經營方式 */
fmng034       varchar2(10)      ,/* 渠道 */
fmng035       varchar2(10)      ,/* 品牌 */
fmng036       varchar2(30)      ,/* 自由核算項一 */
fmng037       varchar2(30)      ,/* 自由核算項二 */
fmng038       varchar2(30)      ,/* 自由核算項三 */
fmng039       varchar2(30)      ,/* 自由核算項四 */
fmng040       varchar2(30)      ,/* 自由核算項五 */
fmng041       varchar2(30)      ,/* 自由核算項六 */
fmng042       varchar2(30)      ,/* 自由核算項七 */
fmng043       varchar2(30)      ,/* 自由核算項八 */
fmng044       varchar2(30)      ,/* 自由核算項九 */
fmng045       varchar2(30)      ,/* 自由核算項十 */
fmng046       varchar2(255)      ,/* 摘要 */
fmngud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmngud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmngud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmngud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmngud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmngud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmngud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmngud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmngud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmngud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmngud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmngud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmngud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmngud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmngud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmngud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmngud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmngud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmngud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmngud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmngud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmngud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmngud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmngud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmngud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmngud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmngud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmngud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmngud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmngud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmng_t add constraint fmng_pk primary key (fmngent,fmngdocno,fmngseq) enable validate;

create unique index fmng_pk on fmng_t (fmngent,fmngdocno,fmngseq);

grant select on fmng_t to tiptop;
grant update on fmng_t to tiptop;
grant delete on fmng_t to tiptop;
grant insert on fmng_t to tiptop;

exit;
