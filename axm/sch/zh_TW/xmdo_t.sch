/* 
================================================================================
檔案代號:xmdo_t
檔案名稱:Invoice單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmdo_t
(
xmdoent       number(5)      ,/* 企業編號 */
xmdosite       varchar2(10)      ,/* 營運據點 */
xmdodocno       varchar2(20)      ,/* 單據單號 */
xmdodocdt       date      ,/* 單據日期 */
xmdo001       varchar2(10)      ,/* Invoice類型 */
xmdo002       varchar2(20)      ,/* 申請人員 */
xmdo003       varchar2(10)      ,/* 申請部門 */
xmdo004       varchar2(10)      ,/* Invoice來源 */
xmdo005       varchar2(20)      ,/* 來源單號 */
xmdo007       varchar2(10)      ,/* 交易對象 */
xmdo008       varchar2(10)      ,/* 收款對象 */
xmdo009       varchar2(10)      ,/* 送貨對象 */
xmdo010       varchar2(10)      ,/* 收款條件 */
xmdo011       varchar2(10)      ,/* 交易條件 */
xmdo012       varchar2(10)      ,/* 稅別 */
xmdo013       number(5,2)      ,/* 稅率 */
xmdo014       varchar2(1)      ,/* 單價含稅否 */
xmdo015       varchar2(2)      ,/* 發票類型 */
xmdo016       varchar2(10)      ,/* 幣別 */
xmdo017       number(20,10)      ,/* 匯率 */
xmdo019       varchar2(10)      ,/* 送貨供應商 */
xmdo020       varchar2(10)      ,/* 送貨地址 */
xmdo021       varchar2(10)      ,/* 運輸方式 */
xmdo022       varchar2(10)      ,/* 交運起點 */
xmdo023       varchar2(10)      ,/* 交運終點 */
xmdo024       varchar2(20)      ,/* 航次/航班/車號 */
xmdo025       date      ,/* 起運日期 */
xmdo026       varchar2(30)      ,/* 嘜頭編號 */
xmdo029       varchar2(10)      ,/* 額外品名規格分類 */
xmdo050       number(20,6)      ,/* 總未稅金額 */
xmdo051       number(20,6)      ,/* 總含稅金額 */
xmdo052       number(20,6)      ,/* 總稅額 */
xmdo053       varchar2(255)      ,/* 備註 */
xmdoownid       varchar2(20)      ,/* 資料所有者 */
xmdoowndp       varchar2(10)      ,/* 資料所屬部門 */
xmdocrtid       varchar2(20)      ,/* 資料建立者 */
xmdocrtdp       varchar2(10)      ,/* 資料建立部門 */
xmdocrtdt       timestamp(0)      ,/* 資料創建日 */
xmdomodid       varchar2(20)      ,/* 資料修改者 */
xmdomoddt       timestamp(0)      ,/* 最近修改日 */
xmdocnfid       varchar2(20)      ,/* 資料確認者 */
xmdocnfdt       timestamp(0)      ,/* 資料確認日 */
xmdopstid       varchar2(20)      ,/* 資料過帳者 */
xmdopstdt       timestamp(0)      ,/* 資料過帳日 */
xmdostus       varchar2(10)      ,/* 狀態碼 */
xmdo054       varchar2(1)      ,/* 多角貿易拋轉否 */
xmdo055       varchar2(20)      ,/* 多角序號 */
xmdo056       varchar2(10)      ,/* 多角流程代碼 */
xmdoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdoud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdo030       varchar2(20)      ,/* P/I No. */
xmdo031       varchar2(20)      ,/* 信用狀號碼 */
xmdo032       varchar2(40)      /* 產地 */
);
alter table xmdo_t add constraint xmdo_pk primary key (xmdoent,xmdodocno) enable validate;

create unique index xmdo_pk on xmdo_t (xmdoent,xmdodocno);

grant select on xmdo_t to tiptop;
grant update on xmdo_t to tiptop;
grant delete on xmdo_t to tiptop;
grant insert on xmdo_t to tiptop;

exit;
