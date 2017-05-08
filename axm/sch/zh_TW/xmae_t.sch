/* 
================================================================================
檔案代號:xmae_t
檔案名稱:銷售控制組客戶預設條件檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmae_t
(
xmaeent       number(5)      ,/* 企業編號 */
xmae001       varchar2(10)      ,/* 交易對象編號 */
xmae002       varchar2(10)      ,/* 控制組編號 */
xmae003       varchar2(10)      ,/* 慣用交易幣別 */
xmae004       varchar2(10)      ,/* 慣用交易稅別 */
xmae005       varchar2(10)      ,/* No use */
xmae006       varchar2(255)      ,/* 慣用收款條件 */
xmae008       varchar2(10)      ,/* 慣用銷售通路 */
xmae009       varchar2(10)      ,/* 慣用銷售分類 */
xmae010       varchar2(6)      ,/* 慣用語言 */
xmae011       varchar2(10)      ,/* 慣用交運方式 */
xmae012       varchar2(10)      ,/* 慣用交運起點 */
xmae013       varchar2(10)      ,/* 慣用交運終點 */
xmae014       varchar2(10)      ,/* 慣用卸貨港 */
xmae015       number(20,6)      ,/* 慣用佣金率 */
xmae016       number(20,6)      ,/* 折扣率 */
xmae017       varchar2(10)      ,/* 慣用ForWarder */
xmae018       varchar2(80)      ,/* 慣用Notify */
xmae019       varchar2(20)      ,/* 慣用業務人員 */
xmae020       varchar2(10)      ,/* 慣用交易條件 */
xmae021       varchar2(10)      ,/* 慣用取價方式 */
xmae022       varchar2(2)      ,/* 慣用發票類型 */
xmaeownid       varchar2(20)      ,/* 資料所有者 */
xmaeowndp       varchar2(10)      ,/* 資料所屬部門 */
xmaecrtid       varchar2(20)      ,/* 資料建立者 */
xmaecrtdp       varchar2(10)      ,/* 資料建立部門 */
xmaecrtdt       timestamp(0)      ,/* 資料創建日 */
xmaemodid       varchar2(20)      ,/* 資料修改者 */
xmaemoddt       timestamp(0)      ,/* 最近修改日 */
xmaestus       varchar2(10)      ,/* 狀態碼 */
xmae023       varchar2(10)      ,/* 內外銷 */
xmae024       varchar2(10)      ,/* 取匯率來源 */
xmae025       varchar2(10)      ,/* 慣用業務部門 */
xmaeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmaeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmaeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmaeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmaeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmaeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmaeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmaeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmaeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmaeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmaeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmaeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmaeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmaeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmaeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmaeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmaeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmaeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmaeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmaeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmaeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmaeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmaeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmaeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmaeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmaeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmaeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmaeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmaeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmaeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmae_t add constraint xmae_pk primary key (xmaeent,xmae001,xmae002) enable validate;

create unique index xmae_pk on xmae_t (xmaeent,xmae001,xmae002);

grant select on xmae_t to tiptop;
grant update on xmae_t to tiptop;
grant delete on xmae_t to tiptop;
grant insert on xmae_t to tiptop;

exit;
