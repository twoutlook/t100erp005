/* 
================================================================================
檔案代號:inpd_t
檔案名稱:盤點明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpd_t
(
inpdent       number(5)      ,/* 企業編號 */
inpdsite       varchar2(10)      ,/* 營運據點 */
inpddocno       varchar2(20)      ,/* 標籤編號 */
inpdseq       number(10,0)      ,/* 項次 */
inpd001       varchar2(40)      ,/* 料件編號 */
inpd002       varchar2(256)      ,/* 產品特徵 */
inpd003       varchar2(30)      ,/* 庫存管理特徵 */
inpd004       varchar2(40)      ,/* 包裝容器編號 */
inpd005       varchar2(10)      ,/* 庫位編號 */
inpd006       varchar2(10)      ,/* 儲位編號 */
inpd007       varchar2(30)      ,/* 批號 */
inpd008       varchar2(20)      ,/* 盤點計劃單號 */
inpd009       varchar2(1)      ,/* 空白標籤 */
inpd010       varchar2(10)      ,/* 庫存單位 */
inpd011       number(20,6)      ,/* 現有庫存量 */
inpd012       varchar2(10)      ,/* 參考單位 */
inpd013       number(20,6)      ,/* 參考單位現有庫存量 */
inpd014       varchar2(10)      ,/* 理由碼 */
inpd015       varchar2(255)      ,/* 備註 */
inpd016       varchar2(20)      ,/* 產生人員 */
inpd017       date      ,/* 產生日期 */
inpd018       date      ,/* 列印日期 */
inpd019       number(10,0)      ,/* 列印次數 */
inpd030       number(20,6)      ,/* 盤點數量-初盤(一) */
inpd031       number(20,6)      ,/* 參考單位盤點量-初盤(一) */
inpd032       varchar2(20)      ,/* 輸入人員-初盤(一) */
inpd033       date      ,/* 輸入日期-初盤(一) */
inpd034       varchar2(20)      ,/* 盤點人員-初盤(一) */
inpd035       date      ,/* 盤點日期-初盤(一) */
inpd036       number(20,6)      ,/* 盤點數量-初盤(二) */
inpd037       number(20,6)      ,/* 參考單位盤點量-初盤(二) */
inpd038       varchar2(20)      ,/* 輸入人員-初盤(二) */
inpd039       date      ,/* 輸入日期-初盤(二) */
inpd040       varchar2(20)      ,/* 盤點人員-初盤(二) */
inpd041       date      ,/* 盤點日期-初盤(二) */
inpd050       number(20,6)      ,/* 盤點數量-複盤(一) */
inpd051       number(20,6)      ,/* 參考單位盤點量-複盤(一) */
inpd052       varchar2(20)      ,/* 輸入人員-複盤(一) */
inpd053       date      ,/* 輸入日期-複盤(一) */
inpd054       varchar2(20)      ,/* 盤點人員-複盤(一) */
inpd055       date      ,/* 盤點日期-複盤(一) */
inpd056       number(20,6)      ,/* 盤點數量-複盤(二) */
inpd057       number(20,6)      ,/* 參考單位盤點量-複盤(二) */
inpd058       varchar2(20)      ,/* 輸入人員-複盤(二) */
inpd059       date      ,/* 輸入日期-複盤(二) */
inpd060       varchar2(20)      ,/* 盤點人員-複盤(二) */
inpd061       date      ,/* 盤點日期-複盤(二) */
inpdownid       varchar2(20)      ,/* 資料所有者 */
inpdowndp       varchar2(10)      ,/* 資料所屬部門 */
inpdcrtid       varchar2(20)      ,/* 資料建立者 */
inpdcrtdp       varchar2(10)      ,/* 資料建立部門 */
inpdcrtdt       timestamp(0)      ,/* 資料創建日 */
inpdmodid       varchar2(20)      ,/* 資料修改者 */
inpdmoddt       timestamp(0)      ,/* 最近修改日 */
inpdcnfid       varchar2(20)      ,/* 資料確認者 */
inpdcnfdt       timestamp(0)      ,/* 資料確認日 */
inpdpstid       varchar2(20)      ,/* 資料過帳者 */
inpdpstdt       timestamp(0)      ,/* 資料過帳日 */
inpdstus       varchar2(10)      ,/* 狀態碼 */
inpdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpd_t add constraint inpd_pk primary key (inpdent,inpdsite,inpddocno,inpdseq) enable validate;

create unique index inpd_pk on inpd_t (inpdent,inpdsite,inpddocno,inpdseq);

grant select on inpd_t to tiptop;
grant update on inpd_t to tiptop;
grant delete on inpd_t to tiptop;
grant insert on inpd_t to tiptop;

exit;
