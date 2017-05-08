/* 
================================================================================
檔案代號:apge_t
檔案名稱:信用狀修改申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table apge_t
(
apgeent       number(5)      ,/* 企業編號 */
apgecomp       varchar2(10)      ,/* 法人 */
apgedocno       varchar2(20)      ,/* 變更單號 */
apgeseq       number(10,0)      ,/* 項次 */
apgeorga       varchar2(10)      ,/* 來源組織 */
apge001       varchar2(20)      ,/* 採購單號 */
apge002       number(10,0)      ,/* 採購單項次 */
apge003       varchar2(40)      ,/* 產品編號 */
apge004       varchar2(255)      ,/* 品名規格 */
apge005       varchar2(10)      ,/* 單位 */
apge006       varchar2(10)      ,/* 稅別 */
apge007       varchar2(1)      ,/* 含稅否 */
apge008       number(20,6)      ,/* 採購數量 */
apge009       number(20,6)      ,/* 原幣含稅單價 */
apge105       number(20,6)      ,/* 原幣含稅金額 */
apge115       number(20,6)      ,/* 本幣含稅金額 */
apge900       number(10,0)      ,/* 變更序 */
apge901       varchar2(1)      ,/* 變更類型 */
apge902       varchar2(10)      ,/* 變更理由 */
apge903       varchar2(255)      ,/* 變更備註 */
apgeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apgeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apgeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apgeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apgeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apgeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apgeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apgeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apgeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apgeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apgeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apgeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apgeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apgeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apgeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apgeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apgeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apgeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apgeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apgeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apgeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apgeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apgeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apgeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apgeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apgeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apgeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apgeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apgeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apgeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apge100       varchar2(10)      ,/* 幣別 */
apge101       number(20,10)      /* 匯率 */
);
alter table apge_t add constraint apge_pk primary key (apgeent,apgecomp,apgedocno,apgeseq,apge900) enable validate;

create unique index apge_pk on apge_t (apgeent,apgecomp,apgedocno,apgeseq,apge900);

grant select on apge_t to tiptop;
grant update on apge_t to tiptop;
grant delete on apge_t to tiptop;
grant insert on apge_t to tiptop;

exit;
