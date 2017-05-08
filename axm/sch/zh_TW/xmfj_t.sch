/* 
================================================================================
檔案代號:xmfj_t
檔案名稱:銷售折扣合約單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmfj_t
(
xmfjent       number(5)      ,/* 企業編號 */
xmfjsite       varchar2(10)      ,/* 營運據點 */
xmfjdocno       varchar2(20)      ,/* 合約單號 */
xmfjdocdt       date      ,/* 單據日期 */
xmfj001       varchar2(20)      ,/* 銷售人員 */
xmfj002       varchar2(10)      ,/* 銷售部門 */
xmfj003       varchar2(10)      ,/* 帳款客戶 */
xmfj004       varchar2(10)      ,/* 幣別 */
xmfj005       varchar2(10)      ,/* 稅別 */
xmfj006       number(5,2)      ,/* 稅率 */
xmfj007       varchar2(1)      ,/* 單價含稅否 */
xmfj008       varchar2(10)      ,/* 收款條件 */
xmfj009       varchar2(10)      ,/* 交易條件 */
xmfj010       varchar2(10)      ,/* 銷售通路 */
xmfj011       date      ,/* 生效日期 */
xmfj012       date      ,/* 失效日期 */
xmfj013       varchar2(1)      ,/* 限定幣別 */
xmfj014       varchar2(1)      ,/* 限定稅別 */
xmfj015       varchar2(1)      ,/* 限定收款條件否 */
xmfj016       varchar2(1)      ,/* 限定交易條件否 */
xmfj017       varchar2(1)      ,/* 限定銷售通路 */
xmfj018       varchar2(1)      ,/* 銷退是否納入計算 */
xmfj019       varchar2(10)      ,/* 帳款產生方式 */
xmfj030       varchar2(255)      ,/* 備註 */
xmfjownid       varchar2(20)      ,/* 資料所有者 */
xmfjowndp       varchar2(10)      ,/* 資料所屬部門 */
xmfjcrtid       varchar2(20)      ,/* 資料建立者 */
xmfjcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmfjcrtdt       timestamp(0)      ,/* 資料創建日 */
xmfjmodid       varchar2(20)      ,/* 資料修改者 */
xmfjmoddt       timestamp(0)      ,/* 最近修改日 */
xmfjcnfid       varchar2(20)      ,/* 資料確認者 */
xmfjcnfdt       timestamp(0)      ,/* 資料確認日 */
xmfjpstid       varchar2(20)      ,/* 資料過帳者 */
xmfjpstdt       timestamp(0)      ,/* 資料過帳日 */
xmfjstus       varchar2(10)      ,/* 狀態碼 */
xmfjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfjud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmfj020       varchar2(10)      /* 付款條件 */
);
alter table xmfj_t add constraint xmfj_pk primary key (xmfjent,xmfjdocno) enable validate;

create unique index xmfj_pk on xmfj_t (xmfjent,xmfjdocno);

grant select on xmfj_t to tiptop;
grant update on xmfj_t to tiptop;
grant delete on xmfj_t to tiptop;
grant insert on xmfj_t to tiptop;

exit;
