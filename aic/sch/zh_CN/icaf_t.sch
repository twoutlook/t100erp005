/* 
================================================================================
檔案代號:icaf_t
檔案名稱:內部直接交易檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table icaf_t
(
icafent       number(5)      ,/* 企業編號 */
icafsite       varchar2(10)      ,/* 營運據點 */
icaf001       varchar2(10)      ,/* 來源對象編號 */
icaf002       varchar2(10)      ,/* 目的對象編號 */
icaf003       varchar2(5)      ,/* 預設採購單別 */
icaf004       varchar2(5)      ,/* 預設收貨單別 */
icaf005       varchar2(5)      ,/* 預設入庫單別 */
icaf006       varchar2(10)      ,/* 預設入庫庫位 */
icaf007       varchar2(10)      ,/* 預設入庫儲位 */
icaf008       varchar2(10)      ,/* 預設採購稅別 */
icaf009       varchar2(5)      ,/* 預設應付單別 */
icaf010       varchar2(5)      ,/* 預設應付折讓單別 */
icaf011       varchar2(10)      ,/* 預設應付責任中心 */
icaf012       varchar2(10)      ,/* 預設應付帳款類型 */
icaf013       varchar2(10)      ,/* 預設付款條件 */
icaf014       varchar2(5)      ,/* 預設訂單單別 */
icaf015       varchar2(5)      ,/* 預設出貨單別 */
icaf016       varchar2(5)      ,/* 預設簽收單別 */
icaf017       varchar2(10)      ,/* 預設出貨庫位 */
icaf018       varchar2(10)      ,/* 預設出貨儲位 */
icaf019       varchar2(10)      ,/* 預設訂單稅別 */
icaf020       varchar2(5)      ,/* 預設應收單別 */
icaf021       varchar2(5)      ,/* 預設應收折讓單別 */
icaf022       varchar2(10)      ,/* 預設應收責任中心 */
icaf023       varchar2(10)      ,/* 預設應收帳款類型 */
icaf024       varchar2(10)      ,/* 預設收款條件 */
icafownid       varchar2(20)      ,/* 資料所有者 */
icafowndp       varchar2(10)      ,/* 資料所屬部門 */
icafcrtid       varchar2(20)      ,/* 資料建立者 */
icafcrtdp       varchar2(10)      ,/* 資料建立部門 */
icafcrtdt       timestamp(0)      ,/* 資料創建日 */
icafmodid       varchar2(20)      ,/* 資料修改者 */
icafmoddt       timestamp(0)      ,/* 最近修改日 */
icafstus       varchar2(10)      ,/* 狀態碼 */
icaf025       varchar2(10)      ,/* 統銷出通單開立點 */
icaf026       varchar2(5)      ,/* 預設出通單別 */
icaf027       varchar2(5)      ,/* 預設Invoice單別 */
icafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
icafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
icafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
icafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
icafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
icafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
icafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
icafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
icafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
icafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
icafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
icafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
icafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
icafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
icafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
icafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
icafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
icafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
icafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
icafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
icafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
icafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
icafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
icafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
icafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
icafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
icafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
icafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
icafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
icafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table icaf_t add constraint icaf_pk primary key (icafent,icaf001,icaf002) enable validate;

create unique index icaf_pk on icaf_t (icafent,icaf001,icaf002);

grant select on icaf_t to tiptop;
grant update on icaf_t to tiptop;
grant delete on icaf_t to tiptop;
grant insert on icaf_t to tiptop;

exit;
