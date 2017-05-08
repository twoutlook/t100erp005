/* 
================================================================================
檔案代號:xmea_t
檔案名稱:銷售合約變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmea_t
(
xmeaent       number(5)      ,/* 企業編號 */
xmeasite       varchar2(10)      ,/* 營運據點 */
xmeadocno       varchar2(20)      ,/* 合約單號 */
xmeadocdt       date      ,/* 單據日期 */
xmea000       number(5,0)      ,/* 版本 */
xmea001       varchar2(1)      ,/* 委外否 */
xmea002       varchar2(20)      ,/* 銷售人員 */
xmea003       varchar2(10)      ,/* 銷售部門 */
xmea004       varchar2(10)      ,/* 客戶 */
xmea005       varchar2(10)      ,/* 幣別 */
xmea006       varchar2(10)      ,/* 稅別 */
xmea007       number(5,2)      ,/* 稅率 */
xmea008       varchar2(10)      ,/* 單價含稅否 */
xmea009       varchar2(10)      ,/* 收款條件 */
xmea010       varchar2(1)      ,/* 限定收款條件否 */
xmea011       varchar2(10)      ,/* 交易條件 */
xmea012       varchar2(1)      ,/* 限定交易條件否 */
xmea013       varchar2(10)      ,/* 核決內容 */
xmea014       date      ,/* 生效日期 */
xmea015       date      ,/* 失效日期 */
xmea016       varchar2(10)      ,/* 合約對像管制 */
xmea017       varchar2(10)      ,/* 合約使用管制 */
xmea018       varchar2(10)      ,/* 合約管制方式 */
xmea019       varchar2(1)      ,/* 限定幣別 */
xmea020       varchar2(1)      ,/* 限定稅別 */
xmea030       varchar2(255)      ,/* 備註 */
xmea900       number(10,0)      ,/* 變更序 */
xmea901       varchar2(1)      ,/* 變更類型 */
xmea902       date      ,/* 變更日期 */
xmea903       varchar2(10)      ,/* 變更理由 */
xmea904       varchar2(255)      ,/* 變更備註 */
xmeaownid       varchar2(20)      ,/* 資料所有者 */
xmeaowndp       varchar2(10)      ,/* 資料所屬部門 */
xmeacrtid       varchar2(20)      ,/* 資料建立者 */
xmeacrtdp       varchar2(10)      ,/* 資料建立部門 */
xmeacrtdt       timestamp(0)      ,/* 資料創建日 */
xmeamodid       varchar2(20)      ,/* 資料修改者 */
xmeamoddt       timestamp(0)      ,/* 最近修改日 */
xmeacnfid       varchar2(20)      ,/* 資料確認者 */
xmeacnfdt       timestamp(0)      ,/* 資料確認日 */
xmeastus       varchar2(10)      ,/* 狀態碼 */
xmeaacti       varchar2(1)      ,/* 銷售合約單結案否 */
xmeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmea_t add constraint xmea_pk primary key (xmeaent,xmeadocno,xmea900) enable validate;

create unique index xmea_pk on xmea_t (xmeaent,xmeadocno,xmea900);

grant select on xmea_t to tiptop;
grant update on xmea_t to tiptop;
grant delete on xmea_t to tiptop;
grant insert on xmea_t to tiptop;

exit;
