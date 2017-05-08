/* 
================================================================================
檔案代號:xmdy_t
檔案名稱:銷售合約單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table xmdy_t
(
xmdyent       number(5)      ,/* 企業編號 */
xmdysite       varchar2(10)      ,/* 營運據點 */
xmdydocno       varchar2(20)      ,/* 合約單號 */
xmdyseq       number(10,0)      ,/* 項次 */
xmdy001       varchar2(1)      ,/* 委外否 */
xmdy002       varchar2(40)      ,/* 料件編號 */
xmdy003       varchar2(256)      ,/* 產品特徵 */
xmdy004       varchar2(40)      ,/* 包裝容器 */
xmdy005       varchar2(40)      ,/* 客戶料號 */
xmdy006       varchar2(10)      ,/* 作業編號 */
xmdy007       varchar2(10)      ,/* 製程序 */
xmdy008       varchar2(10)      ,/* 單位 */
xmdy009       number(20,6)      ,/* 數量 */
xmdy010       number(20,6)      ,/* 單價 */
xmdy011       varchar2(10)      ,/* 稅別 */
xmdy012       number(5,2)      ,/* 稅率 */
xmdy013       varchar2(10)      ,/* 運輸方式 */
xmdy014       varchar2(10)      ,/* 理由碼 */
xmdy017       number(20,6)      ,/* 未稅金額 */
xmdy018       number(20,6)      ,/* 含稅金額 */
xmdy019       number(20,6)      ,/* 稅額 */
xmdy020       number(20,6)      ,/* 累計數量 */
xmdy021       number(20,6)      ,/* 累計未稅金額 */
xmdy022       number(20,6)      ,/* 累計含稅金額 */
xmdy023       number(20,6)      ,/* 累計稅額 */
xmdy024       varchar2(1)      ,/* 累計量定價否 */
xmdy030       varchar2(255)      ,/* 備註 */
xmdyud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdyud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdyud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdyud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdyud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdyud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdyud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdyud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdyud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdyud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdyud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdyud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdyud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdyud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdyud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdyud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdyud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdyud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdyud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdyud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdyud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdyud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdyud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdyud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdyud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdyud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdyud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdyud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdyud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdyud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdy_t add constraint xmdy_pk primary key (xmdyent,xmdydocno,xmdyseq) enable validate;

create unique index xmdy_pk on xmdy_t (xmdyent,xmdydocno,xmdyseq);

grant select on xmdy_t to tiptop;
grant update on xmdy_t to tiptop;
grant delete on xmdy_t to tiptop;
grant insert on xmdy_t to tiptop;

exit;
