/* 
================================================================================
檔案代號:glan_t
檔案名稱:分攤金額來源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glan_t
(
glanent       number(5)      ,/* 企業編號 */
glanownid       varchar2(20)      ,/* 資料所有者 */
glanowndp       varchar2(10)      ,/* 資料所屬部門 */
glancrtid       varchar2(20)      ,/* 資料建立者 */
glancrtdp       varchar2(10)      ,/* 資料建立部門 */
glancrtdt       timestamp(0)      ,/* 資料創建日 */
glanmodid       varchar2(20)      ,/* 資料修改者 */
glanmoddt       timestamp(0)      ,/* 最近修改日 */
glancnfid       varchar2(20)      ,/* 資料確認者 */
glancnfdt       timestamp(0)      ,/* 資料確認日 */
glanpstid       varchar2(20)      ,/* 資料過帳者 */
glanpstdt       timestamp(0)      ,/* 資料過帳日 */
glanstus       varchar2(10)      ,/* 狀態碼 */
glanld       varchar2(5)      ,/* 帳別(套)編號 */
glandocno       varchar2(20)      ,/* 分攤編號 */
glanseq       number(10,0)      ,/* 項次 */
glan001       varchar2(24)      ,/* 科目編號 */
glan002       number(20,6)      ,/* 分攤百分比 */
glan003       varchar2(10)      ,/* 營運據點 */
glan004       varchar2(10)      ,/* 部門 */
glan005       varchar2(10)      ,/* 利潤/成本中心 */
glan006       varchar2(10)      ,/* 區域 */
glan007       varchar2(10)      ,/* 交易客商 */
glan008       varchar2(10)      ,/* 帳款客商 */
glan009       varchar2(10)      ,/* 客群 */
glan010       varchar2(10)      ,/* 產品類別 */
glan011       varchar2(20)      ,/* 人員 */
glan012       varchar2(10)      ,/* no use */
glan013       varchar2(20)      ,/* 專案編號 */
glan014       varchar2(30)      ,/* WBS */
glan015       varchar2(1)      ,/* 餘額來源 */
glan016       varchar2(1)      ,/* 餘額性質 */
glan017       varchar2(1)      ,/* 來源性質 */
glan018       number(5,0)      ,/* 餘額來源年度 */
glan019       number(5,0)      ,/* 餘額來源期別 */
glan051       varchar2(10)      ,/* 經營方式 */
glan052       varchar2(10)      ,/* 渠道 */
glan053       varchar2(10)      ,/* 品牌 */
glanud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glanud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glanud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glanud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glanud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glanud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glanud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glanud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glanud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glanud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glanud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glanud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glanud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glanud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glanud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glanud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glanud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glanud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glanud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glanud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glanud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glanud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glanud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glanud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glanud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glanud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glanud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glanud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glanud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glanud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glan_t add constraint glan_pk primary key (glanent,glanld,glandocno,glanseq) enable validate;

create unique index glan_pk on glan_t (glanent,glanld,glandocno,glanseq);

grant select on glan_t to tiptop;
grant update on glan_t to tiptop;
grant delete on glan_t to tiptop;
grant insert on glan_t to tiptop;

exit;
