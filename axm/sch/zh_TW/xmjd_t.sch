/* 
================================================================================
檔案代號:xmjd_t
檔案名稱:訂貨會訂貨明細調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmjd_t
(
xmjdent       number(5)      ,/* 企業編號 */
xmjdsite       varchar2(10)      ,/* 營運據點 */
xmjd001       number(5,0)      ,/* 年份 */
xmjd002       varchar2(10)      ,/* 訂貨季 */
xmjd003       varchar2(10)      ,/* 對象類型 */
xmjd004       varchar2(10)      ,/* 對象編號 */
xmjd005       varchar2(500)      ,/* 對象說明 */
xmjd006       varchar2(20)      ,/* 訂單單號 */
xmjd007       varchar2(10)      ,/* 訂單序號 */
xmjd008       varchar2(80)      ,/* 款號 */
xmjd009       number(20,6)      ,/* 吊牌價 */
xmjd010       varchar2(30)      ,/* 顏色編號 */
xmjd011       varchar2(500)      ,/* 顏色說明 */
xmjd012       varchar2(30)      ,/* 尺寸編號 */
xmjd013       varchar2(500)      ,/* 尺寸說明 */
xmjd014       number(20,6)      ,/* 轉入量 */
xmjd015       number(20,6)      ,/* 調整量 */
xmjd016       number(20,6)      ,/* 吊牌金額 */
xmjd017       varchar2(10)      ,/* 處理狀態 */
xmjd018       varchar2(40)      ,/* 區域 */
xmjd019       varchar2(40)      ,/* 代理 */
xmjd020       varchar2(40)      ,/* 品牌 */
xmjd021       varchar2(40)      ,/* 系列 */
xmjd022       varchar2(40)      ,/* 年齡段 */
xmjd023       varchar2(40)      ,/* 季節 */
xmjd024       varchar2(40)      ,/* 波段 */
xmjd025       varchar2(40)      ,/* 性別 */
xmjd026       varchar2(40)      ,/* 上下裝 */
xmjd027       varchar2(40)      ,/* 類別 */
xmjd028       varchar2(40)      ,/* 小類 */
xmjd029       varchar2(40)      ,/* 款式屬性 */
xmjd030       varchar2(40)      ,/* 價格帶 */
xmjd031       varchar2(40)      ,/* 面料 */
xmjdstus       varchar2(10)      ,/* 狀態碼 */
xmjdownid       varchar2(20)      ,/* 資料所有者 */
xmjdowndp       varchar2(10)      ,/* 資料所屬部門 */
xmjdcrtid       varchar2(20)      ,/* 資料建立者 */
xmjdcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmjdcrtdt       timestamp(0)      ,/* 資料創建日 */
xmjdmodid       varchar2(20)      ,/* 資料修改者 */
xmjdmoddt       timestamp(0)      ,/* 最近修改日 */
xmjdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmjdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmjdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmjdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmjdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmjdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmjdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmjdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmjdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmjdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmjdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmjdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmjdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmjdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmjdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmjdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmjdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmjdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmjdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmjdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmjdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmjdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmjdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmjdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmjdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmjdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmjdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmjdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmjdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmjdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmjd_t add constraint xmjd_pk primary key (xmjdent,xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012) enable validate;

create unique index xmjd_pk on xmjd_t (xmjdent,xmjd001,xmjd002,xmjd003,xmjd004,xmjd008,xmjd010,xmjd012);

grant select on xmjd_t to tiptop;
grant update on xmjd_t to tiptop;
grant delete on xmjd_t to tiptop;
grant insert on xmjd_t to tiptop;

exit;
