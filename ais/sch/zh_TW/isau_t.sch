/* 
================================================================================
檔案代號:isau_t
檔案名稱:進項發票歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table isau_t
(
isauent       number(5)      ,/* 企業編碼 */
isaucomp       varchar2(10)      ,/* 法人 */
isaudocno       varchar2(20)      ,/* 開票單號 */
isauseq       number(10,0)      ,/* 發票歷程項次 */
isau001       varchar2(2)      ,/* 發票類型 */
isau002       varchar2(1)      ,/* 電子發票否 */
isau003       varchar2(20)      ,/* 發票代碼 */
isau004       varchar2(20)      ,/* 發票號碼 */
isau005       varchar2(10)      ,/* 發票聯數 */
isau006       varchar2(10)      ,/* 發票防偽隨機碼 */
isau007       date      ,/* 發票日期 */
isau008       timestamp(5)      ,/* 發票時間 */
isau009       varchar2(255)      ,/* 發票客戶全名 */
isau010       varchar2(20)      ,/* 購貨方稅務編號 */
isau011       varchar2(4000)      ,/* 購貨方地址 */
isau012       varchar2(20)      ,/* 銷方稅務編號 */
isau013       varchar2(20)      ,/* POS單號 */
isau014       varchar2(10)      ,/* 發票異動狀態 */
isau015       varchar2(10)      ,/* 異動理由碼 */
isau016       varchar2(255)      ,/* 異動備註 */
isau017       date      ,/* 異動日期 */
isau018       varchar2(8)      ,/* 異動時間 */
isau019       varchar2(20)      ,/* 異動人員 */
isau020       varchar2(80)      ,/* 專案作廢核准文號 */
isau021       number(5,0)      ,/* 列印次數 */
isau022       varchar2(10)      ,/* 發票聯別 */
isau023       varchar2(1)      ,/* 課稅別 */
isau024       number(20,6)      ,/* 稅率 */
isau100       varchar2(10)      ,/* 幣別 */
isau101       number(20,10)      ,/* 匯率 */
isau103       number(20,6)      ,/* 發票原幣未稅金額 */
isau104       number(20,6)      ,/* 發票原幣稅額 */
isau105       number(20,6)      ,/* 發票原幣含稅金額 */
isau106       number(20,6)      ,/* 已折讓本幣未稅金額 */
isau107       number(20,6)      ,/* 已折讓本幣稅額 */
isau113       number(20,6)      ,/* 發票本幣未稅金額 */
isau114       number(20,6)      ,/* 發票本幣稅額 */
isau115       number(20,6)      ,/* 發票本幣含稅金額 */
isau201       number(20,6)      ,/* 帳款應稅金額 */
isau202       number(20,6)      ,/* 帳款零稅金額 */
isau203       number(20,6)      ,/* 帳款免稅金額 */
isau204       varchar2(10)      ,/* 愛心碼 */
isau205       varchar2(10)      ,/* 載具類別號碼 */
isau206       varchar2(80)      ,/* 載具顯碼 ID */
isau207       varchar2(80)      ,/* 載具隱碼 ID */
isau208       varchar2(1)      ,/* 電子發票匯出狀態 */
isau209       varchar2(20)      ,/* 電子發票匯出序號 */
isauownid       varchar2(20)      ,/* 資料所有者 */
isauowndp       varchar2(10)      ,/* 資料所屬部門 */
isaucrtid       varchar2(20)      ,/* 資料建立者 */
isaucrtdp       varchar2(10)      ,/* 資料建立部門 */
isaucrtdt       timestamp(0)      ,/* 資料創建日 */
isaumodid       varchar2(20)      ,/* 資料修改者 */
isaumoddt       timestamp(0)      ,/* 最近修改日 */
isaucnfid       varchar2(20)      ,/* 資料確認者 */
isaucnfdt       timestamp(0)      ,/* 資料確認日 */
isaupstid       varchar2(20)      ,/* 資料過帳者 */
isaupstdt       timestamp(0)      ,/* 資料過帳日 */
isaustus       varchar2(10)      ,/* 狀態碼 */
isauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isauud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isau_t add constraint isau_pk primary key (isauent,isaudocno,isauseq,isau003,isau004) enable validate;

create  index isau_n1 on isau_t (isauent,isaucomp,isau003,isau004,isau014);
create unique index isau_pk on isau_t (isauent,isaudocno,isauseq,isau003,isau004);

grant select on isau_t to tiptop;
grant update on isau_t to tiptop;
grant delete on isau_t to tiptop;
grant insert on isau_t to tiptop;

exit;
