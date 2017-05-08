/* 
================================================================================
檔案代號:inpf_t
檔案名稱:在製工單盤點單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inpf_t
(
inpfent       number(5)      ,/* 企業編號 */
inpfsite       varchar2(10)      ,/* 營運據點 */
inpfdocno       varchar2(20)      ,/* 標籤編號 */
inpfseq       number(10,0)      ,/* 項次 */
inpf001       varchar2(20)      ,/* 工單單號 */
inpf002       varchar2(10)      ,/* 作業編號 */
inpf003       varchar2(40)      ,/* 生產料號 */
inpf004       varchar2(20)      ,/* 盤點計劃單號 */
inpf005       varchar2(1)      ,/* 空白標籤 */
inpf006       varchar2(10)      ,/* 部門廠商 */
inpf007       number(20,6)      ,/* 生產數量 */
inpf008       varchar2(10)      ,/* 生產單位 */
inpf009       varchar2(10)      ,/* 製程編號 */
inpf010       number(20,6)      ,/* 已發料套數 */
inpf011       number(20,6)      ,/* 已入庫合格量 */
inpf012       number(20,6)      ,/* 已入庫不合格量 */
inpf013       number(20,6)      ,/* 報廢量 */
inpf014       varchar2(255)      ,/* 備註 */
inpf015       varchar2(20)      ,/* 產生人員 */
inpf016       date      ,/* 產生日期 */
inpf017       date      ,/* 列印日期 */
inpf018       number(10,0)      ,/* 列印次數 */
inpf020       varchar2(20)      ,/* 輸入人員-初盤一 */
inpf021       date      ,/* 輸入日期-初盤一 */
inpf022       varchar2(20)      ,/* 輸入人員-初盤二 */
inpf023       date      ,/* 輸入日期-初盤二 */
inpf024       varchar2(20)      ,/* 輸入人員-複盤一 */
inpf025       date      ,/* 輸入日期-複盤一 */
inpf026       varchar2(20)      ,/* 輸入人員-複盤二 */
inpf027       date      ,/* 輸入日期-複盤二 */
inpfownid       varchar2(20)      ,/* 資料所有者 */
inpfowndp       varchar2(10)      ,/* 資料所有部門 */
inpfcrtid       varchar2(20)      ,/* 資料建立者 */
inpfcrtdp       varchar2(10)      ,/* 資料建立部門 */
inpfcrtdt       timestamp(0)      ,/* 資料創建日 */
inpfmodid       varchar2(20)      ,/* 資料修改者 */
inpfmoddt       timestamp(0)      ,/* 最近修改日 */
inpfcnfid       varchar2(20)      ,/* 資料確認者 */
inpfcnfdt       timestamp(0)      ,/* 資料確認日 */
inpfpstid       varchar2(20)      ,/* 資料過帳者 */
inpfpstdt       timestamp(0)      ,/* 資料過帳日 */
inpfstus       varchar2(10)      ,/* 狀態碼 */
inpfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpf_t add constraint inpf_pk primary key (inpfent,inpfsite,inpfdocno,inpfseq) enable validate;

create unique index inpf_pk on inpf_t (inpfent,inpfsite,inpfdocno,inpfseq);

grant select on inpf_t to tiptop;
grant update on inpf_t to tiptop;
grant delete on inpf_t to tiptop;
grant insert on inpf_t to tiptop;

exit;
