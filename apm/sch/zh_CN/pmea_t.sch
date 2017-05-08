/* 
================================================================================
檔案代號:pmea_t
檔案名稱:採購合約變更單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmea_t
(
pmeaent       number(5)      ,/* 企業編號 */
pmeasite       varchar2(10)      ,/* 營運據點 */
pmeadocno       varchar2(20)      ,/* 合約單號 */
pmeadocdt       date      ,/* 單據日期 */
pmeaacti       varchar2(1)      ,/* 合約結案否 */
pmea000       number(5,0)      ,/* 版本 */
pmea001       varchar2(1)      ,/* 委外否 */
pmea002       varchar2(20)      ,/* 採購人員 */
pmea003       varchar2(10)      ,/* 採購部門 */
pmea004       varchar2(10)      ,/* 供應商 */
pmea005       varchar2(10)      ,/* 幣別 */
pmea006       varchar2(10)      ,/* 稅別 */
pmea007       number(5,2)      ,/* 稅率 */
pmea008       varchar2(1)      ,/* 單價含稅否 */
pmea009       varchar2(10)      ,/* 付款條件 */
pmea010       varchar2(1)      ,/* 限定付款條件否 */
pmea011       varchar2(10)      ,/* 交易條件 */
pmea012       varchar2(1)      ,/* 限定交易條件否 */
pmea013       varchar2(10)      ,/* 核決內容 */
pmea014       date      ,/* 生效日期 */
pmea015       date      ,/* 失效日期 */
pmea016       varchar2(10)      ,/* 合約對象管制 */
pmea017       varchar2(10)      ,/* 合約使用管制 */
pmea018       varchar2(10)      ,/* 合約管制方式 */
pmea019       varchar2(1)      ,/* 限定幣別 */
pmea020       varchar2(1)      ,/* 限定稅別 */
pmea030       varchar2(255)      ,/* 備註 */
pmea900       number(10,0)      ,/* 變更序 */
pmea901       varchar2(1)      ,/* 變更類型 */
pmea902       date      ,/* 變更日期 */
pmea903       varchar2(10)      ,/* 變更理由 */
pmea904       varchar2(255)      ,/* 變更備註 */
pmeaownid       varchar2(20)      ,/* 資料所有者 */
pmeaowndp       varchar2(10)      ,/* 資料所屬部門 */
pmeacrtid       varchar2(20)      ,/* 資料建立者 */
pmeacrtdp       varchar2(10)      ,/* 資料建立部門 */
pmeacrtdt       timestamp(0)      ,/* 資料創建日 */
pmeamodid       varchar2(20)      ,/* 資料修改者 */
pmeamoddt       timestamp(0)      ,/* 最近修改日 */
pmeacnfid       varchar2(20)      ,/* 資料確認者 */
pmeacnfdt       timestamp(0)      ,/* 資料確認日 */
pmeastus       varchar2(10)      ,/* 狀態碼 */
pmeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmea_t add constraint pmea_pk primary key (pmeaent,pmeadocno,pmea900) enable validate;

create unique index pmea_pk on pmea_t (pmeaent,pmeadocno,pmea900);

grant select on pmea_t to tiptop;
grant update on pmea_t to tiptop;
grant delete on pmea_t to tiptop;
grant insert on pmea_t to tiptop;

exit;
