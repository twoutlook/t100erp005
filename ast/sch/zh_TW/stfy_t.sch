/* 
================================================================================
檔案代號:stfy_t
檔案名稱:合同进项税变更单身表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfy_t
(
stfyent       number(5)      ,/* 企業代碼 */
stfysite       varchar2(10)      ,/* 營運據點 */
stfyunit       varchar2(10)      ,/* 應用執行組織物件 */
stfydocno       varchar2(20)      ,/* 單據編號 */
stfyseq       number(10,0)      ,/* 項次 */
stfy001       varchar2(20)      ,/* 來源單號 */
stfy002       number(10,0)      ,/* 來源單項次 */
stfy003       varchar2(10)      ,/* 來源組織 */
stfy004       varchar2(10)      ,/* 版本 */
stfy005       varchar2(40)      ,/* 商品編號 */
stfy006       varchar2(10)      ,/* 原稅別 */
stfy007       number(5,2)      ,/* 稅率 */
stfy008       varchar2(1)      ,/* 原含發票否 */
stfy009       number(20,6)      ,/* 未稅金額 */
stfy010       number(20,6)      ,/* 含稅金額 */
stfy011       number(20,6)      ,/* 稅額 */
stfy012       varchar2(10)      ,/* 結算中心 */
stfy013       varchar2(10)      ,/* 管理品類 */
stfy014       varchar2(10)      ,/* 單據類別 */
stfy015       varchar2(10)      ,/* 單據來源 */
stfyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stfyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stfyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stfyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stfyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stfyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stfyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stfyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stfyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stfyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stfyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stfyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stfyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stfyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stfyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stfyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stfyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stfyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stfyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stfyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stfyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stfyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stfyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stfyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stfyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stfyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stfyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stfyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stfyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stfyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stfy_t add constraint stfy_pk primary key (stfyent,stfydocno,stfyseq) enable validate;

create unique index stfy_pk on stfy_t (stfyent,stfydocno,stfyseq);

grant select on stfy_t to tiptop;
grant update on stfy_t to tiptop;
grant delete on stfy_t to tiptop;
grant insert on stfy_t to tiptop;

exit;
