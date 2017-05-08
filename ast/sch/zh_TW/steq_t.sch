/* 
================================================================================
檔案代號:steq_t
檔案名稱:专柜人员合同资料申请档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table steq_t
(
steqent       number(5)      ,/* 企業編號 */
steqsite       varchar2(10)      ,/* 營運據點 */
stequnit       varchar2(10)      ,/* 應用組織 */
steqdocdt       date      ,/* 單據日期 */
steqacti       varchar2(20)      ,/* 人員合同有效否 */
steqdocno       varchar2(20)      ,/* 單據編號 */
steq000       varchar2(10)      ,/* 作業方式 */
steq001       varchar2(20)      ,/* 人員合同編號 */
steq002       varchar2(10)      ,/* 版本 */
steq003       varchar2(10)      ,/* 專櫃編號 */
steq004       varchar2(10)      ,/* 供應商編號 */
steq005       number(5,0)      ,/* 定編人數 */
steq006       number(20,6)      ,/* 應繳服務質量保證金 */
steq007       varchar2(20)      ,/* 應繳服務保證金費用單號 */
steq008       number(20,6)      ,/* 個人應繳促銷管理費 */
steq009       number(20,6)      ,/* 未滿半年應扣違約金 */
steq010       varchar2(20)      ,/* 手冊編號 */
steq011       number(20,6)      ,/* 轉崗費用金額 */
steq012       number(20,6)      ,/* 工牌押金 */
steq013       varchar2(20)      ,/* 業務人員 */
steq014       varchar2(255)      ,/* 備註 */
steqownid       varchar2(20)      ,/* 資料所屬者 */
steqowndp       varchar2(10)      ,/* 資料所有部門 */
steqcrtid       varchar2(20)      ,/* 資料建立者 */
steqcrtdp       varchar2(10)      ,/* 資料建立部門 */
steqcrtdt       timestamp(0)      ,/* 資料創建日 */
steqmodid       varchar2(20)      ,/* 資料修改者 */
steqmoddt       timestamp(0)      ,/* 最近修改日 */
steqcnfid       varchar2(20)      ,/* 資料確認者 */
steqcnfdt       timestamp(0)      ,/* 資料確認日 */
steqstus       varchar2(10)      ,/* 狀態碼 */
stequd001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stequd002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stequd003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stequd004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stequd005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stequd006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stequd007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stequd008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stequd009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stequd010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stequd011       number(20,6)      ,/* 自定義欄位(數字)011 */
stequd012       number(20,6)      ,/* 自定義欄位(數字)012 */
stequd013       number(20,6)      ,/* 自定義欄位(數字)013 */
stequd014       number(20,6)      ,/* 自定義欄位(數字)014 */
stequd015       number(20,6)      ,/* 自定義欄位(數字)015 */
stequd016       number(20,6)      ,/* 自定義欄位(數字)016 */
stequd017       number(20,6)      ,/* 自定義欄位(數字)017 */
stequd018       number(20,6)      ,/* 自定義欄位(數字)018 */
stequd019       number(20,6)      ,/* 自定義欄位(數字)019 */
stequd020       number(20,6)      ,/* 自定義欄位(數字)020 */
stequd021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stequd022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stequd023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stequd024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stequd025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stequd026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stequd027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stequd028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stequd029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stequd030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table steq_t add constraint steq_pk primary key (steqent,steqdocno) enable validate;

create unique index steq_pk on steq_t (steqent,steqdocno);

grant select on steq_t to tiptop;
grant update on steq_t to tiptop;
grant delete on steq_t to tiptop;
grant insert on steq_t to tiptop;

exit;
