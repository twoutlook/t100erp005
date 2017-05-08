/* 
================================================================================
檔案代號:pmeb_t
檔案名稱:採購合約變更單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmeb_t
(
pmebent       number(5)      ,/* 企業編號 */
pmebsite       varchar2(10)      ,/* 營運據點 */
pmebdocno       varchar2(20)      ,/* 合約單號 */
pmeb900       number(10,0)      ,/* 變更序 */
pmebseq       number(10,0)      ,/* 項次 */
pmeb001       varchar2(1)      ,/* 委外否 */
pmeb002       varchar2(40)      ,/* 料件編號 */
pmeb003       varchar2(256)      ,/* 產品特徵 */
pmeb004       varchar2(40)      ,/* 包裝容器 */
pmeb005       varchar2(40)      ,/* 供應商料號 */
pmeb006       varchar2(10)      ,/* 作業編號 */
pmeb007       varchar2(10)      ,/* 作業序 */
pmeb008       varchar2(10)      ,/* 單位 */
pmeb009       number(20,6)      ,/* 數量 */
pmeb010       number(20,6)      ,/* 單價 */
pmeb011       varchar2(10)      ,/* 稅別 */
pmeb012       number(5,2)      ,/* 稅率 */
pmeb013       varchar2(10)      ,/* 運輸方式 */
pmeb014       varchar2(10)      ,/* 理由碼 */
pmeb017       number(20,6)      ,/* 未稅金額 */
pmeb018       number(20,6)      ,/* 含稅金額 */
pmeb019       number(20,6)      ,/* 稅額 */
pmeb020       number(20,6)      ,/* 累計數量 */
pmeb021       number(20,6)      ,/* 累計未稅金額 */
pmeb022       number(20,6)      ,/* 累計含稅金額 */
pmeb023       number(20,6)      ,/* 累計稅額 */
pmeb024       varchar2(1)      ,/* 累計量定價否 */
pmeb030       varchar2(255)      ,/* 備註 */
pmeb901       varchar2(10)      ,/* 變更類型 */
pmeb902       varchar2(10)      ,/* 變更理由 */
pmeb903       varchar2(255)      ,/* 變更備註 */
pmebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmeb_t add constraint pmeb_pk primary key (pmebent,pmebdocno,pmeb900,pmebseq) enable validate;

create unique index pmeb_pk on pmeb_t (pmebent,pmebdocno,pmeb900,pmebseq);

grant select on pmeb_t to tiptop;
grant update on pmeb_t to tiptop;
grant delete on pmeb_t to tiptop;
grant insert on pmeb_t to tiptop;

exit;
