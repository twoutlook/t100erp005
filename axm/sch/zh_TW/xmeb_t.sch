/* 
================================================================================
檔案代號:xmeb_t
檔案名稱:銷售合約變更單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmeb_t
(
xmebent       number(5)      ,/* 企業編號 */
xmebsite       varchar2(10)      ,/* 營運據點 */
xmebdocno       varchar2(20)      ,/* 合約單號 */
xmeb900       number(10,0)      ,/* 變更序 */
xmebseq       number(10,0)      ,/* 項次 */
xmeb001       varchar2(1)      ,/* 委外否 */
xmeb002       varchar2(40)      ,/* 料件編號 */
xmeb003       varchar2(256)      ,/* 產品特徵 */
xmeb004       varchar2(40)      ,/* 包裝容器 */
xmeb005       varchar2(40)      ,/* 客戶料號 */
xmeb006       varchar2(10)      ,/* 作業編號 */
xmeb007       varchar2(10)      ,/* 製程序 */
xmeb008       varchar2(10)      ,/* 單位 */
xmeb009       number(20,6)      ,/* 數量 */
xmeb010       number(20,6)      ,/* 單價 */
xmeb011       varchar2(10)      ,/* 稅別 */
xmeb012       number(5,2)      ,/* 稅率 */
xmeb013       varchar2(10)      ,/* 運輸方式 */
xmeb014       varchar2(10)      ,/* 理由碼 */
xmeb017       number(20,6)      ,/* 未稅金額 */
xmeb018       number(20,6)      ,/* 含稅金額 */
xmeb019       number(20,6)      ,/* 稅額 */
xmeb020       number(20,6)      ,/* 累計數量 */
xmeb021       number(20,6)      ,/* 累計未稅金額 */
xmeb022       number(20,6)      ,/* 累計含稅金額 */
xmeb023       number(20,6)      ,/* 累計稅額 */
xmeb024       varchar2(1)      ,/* 累計量定價否 */
xmeb030       varchar2(255)      ,/* 備註 */
xmeb901       varchar2(1)      ,/* 變更類型 */
xmeb902       varchar2(10)      ,/* 變更理由 */
xmeb903       varchar2(255)      ,/* 變更備註 */
xmebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmeb_t add constraint xmeb_pk primary key (xmebent,xmebdocno,xmeb900,xmebseq) enable validate;

create unique index xmeb_pk on xmeb_t (xmebent,xmebdocno,xmeb900,xmebseq);

grant select on xmeb_t to tiptop;
grant update on xmeb_t to tiptop;
grant delete on xmeb_t to tiptop;
grant insert on xmeb_t to tiptop;

exit;
